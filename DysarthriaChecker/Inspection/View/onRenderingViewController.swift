//
//  onRenderingViewController.swift
//  DysarthriaChecker
//
//  Created by 하창진 on 7/13/23.
//

import Foundation
import SwiftUI
import UIKit
import Metal
import MetalKit

struct onRenderingView: UIViewRepresentable{
    typealias UIViewType = MTKView
    @Environment(\.presentationMode) var presentationmode

    let spectrograms: [[Double]]
    let elementWidth: CGFloat
    
    var closeView = false

    func makeCoordinator() -> Coordinator {
        Coordinator(self)
    }
    
    func makeUIView(context: Context) -> MTKView {
        let metalView = MTLCreateSystemDefaultDevice().map { MTKView(frame: CGRect(x: 0, y: 0, width: 480, height: 480), device: $0) }
        metalView?.delegate = context.coordinator
        metalView?.framebufferOnly = false
        metalView?.colorPixelFormat = .bgra8Unorm
        metalView?.preferredFramesPerSecond = 30
        metalView?.enableSetNeedsDisplay = true

        context.coordinator.renderSpectrogram(spectrograms: spectrograms, elementWidth: elementWidth)
        
        return metalView!
    }
    
    func updateUIView(_ uiView: MTKView, context: Context) {
        if closeView{
            self.presentationmode.wrappedValue.dismiss()
        }
    }
    
    class Coordinator: NSObject, MTKViewDelegate{
        private let renderer = MetalRenderer()
        private var spectrograms = [[Double]]()
        
        var parent: onRenderingView
        
        init(_ parent: onRenderingView){
            self.parent = parent
        }
        
        func renderSpectrogram(spectrograms: [[Double]], elementWidth: CGFloat){
            self.spectrograms = spectrograms
            renderer.setup()
            let rect = CGRect(x: 0, y: 0, width: 480, height: 480)
            let elementsCount = spectrograms.count
            guard elementsCount > 1 else{
                print("Inspection terminated because elements count is under 1")
                return
            }
            
            let startElement = Int(rect.origin.x / elementWidth)
            let endElement = Int(ceil(rect.maxX / elementWidth) + 1)
            
            guard startElement >= 0 else{
                print("Inspection terminated because start element is under 0")
                return
            }
            
            guard startElement < endElement else{
                print("Inspection terminated because start element is under end element")
                return
            }
            
            var bytes = [UInt8]()
            
            let cols = endElement - startElement - 1
            let items = elementsValueInSpectrogram(at: 0)
            let rows = items.count
            
            for index in startElement...endElement - 1{
                let items = elementsValueInSpectrogram(at: index)
                
                if items.count > 0{
                    for value in items{
                        if !value.isNaN{
                            let dbValue = value * 100
                            bytes.append(UInt8(round(min(max(dbValue, 0), 255))))
                        } else{
                            bytes.append(0)
                        }
                    }
                } else{
                    print("null contents filled because items.count < 0.")
                    bytes.append(contentsOf: [UInt8](repeating: 0, count: rows))
                }
            }
            
            let texture = MTLCreateSystemDefaultDevice()?.createRedTexture(from: bytes, width: rows, height: cols)

            texture.map{
                renderer.send(texture: $0)
            }
        }
        
        private func elementsValueInSpectrogram(at index: Int) -> [Double] {
            if index < spectrograms.count {
                return spectrograms[index]
            }
            else {
                return [Double]()
            }
        }

        func mtkView(_ view: MTKView, drawableSizeWillChange size: CGSize) {
            
        }
        
        func draw(in view: MTKView) {

            guard let currentRenderPassDescriptor = view.currentRenderPassDescriptor,
                  let currentDrawable = view.currentDrawable
            else {
                print("currentRenderPassDescriptor, currentDrawable not match")
                return
            }
            
            renderer.render(with: currentRenderPassDescriptor, drawable: currentDrawable)
            
            let image = currentDrawable.texture.toCGImage()
            
            if image != nil{
                // TODO: Save CGImage to Sandbox for inspection
            } else{
                print("Inspection terminated because created mel-spectrogram image is nil.")
            }
            
            parent.closeView = true
        }

    }
}
