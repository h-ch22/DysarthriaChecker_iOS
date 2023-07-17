//
//  onRenderingView.swift
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
    @EnvironmentObject var helper : InspectionHelper
    
    let spectrograms: [[Double]]
    let elementWidth: CGFloat
    
    var closeView = false

    func makeCoordinator() -> Coordinator {
        Coordinator(self, helper: helper)
    }
    
    func makeUIView(context: Context) -> MTKView {
        let metalView = MTLCreateSystemDefaultDevice().map { MTKView(frame: CGRect(x: 0, y: 0, width: 640, height: 480), device: $0) }
        metalView?.framebufferOnly = false
        metalView?.colorPixelFormat = .bgra8Unorm
        metalView?.preferredFramesPerSecond = 30
        metalView?.contentMode = .scaleAspectFit
        metalView?.autoResizeDrawable = false
        metalView?.enableSetNeedsDisplay = true
        metalView?.delegate = context.coordinator

        context.coordinator.renderSpectrogram(spectrograms: spectrograms, elementWidth: elementWidth)
        
        return metalView!
    }
    
    func updateUIView(_ uiView: MTKView, context: Context) {
        if helper.progress == .RENDER_SPECTROGRAM{
            print("closeView variable modified to true")
            self.presentationmode.wrappedValue.dismiss()
        }
    }
    
    class Coordinator: NSObject, MTKViewDelegate{
        private let renderer = MetalRenderer()
        private var spectrograms = [[Double]]()
        
        var parent: onRenderingView
        var helper: InspectionHelper
        
        init(_ parent: onRenderingView, helper: InspectionHelper){
            self.parent = parent
            self.helper = helper
        }
        
        func renderSpectrogram(spectrograms: [[Double]], elementWidth: CGFloat){
            self.spectrograms = spectrograms
            renderer.setup()
            renderer.scaleFactor = Float(elementWidth)
            let rect = CGRect(x: 0, y: 0, width: 640, height: 480)
            let elementsCount = spectrograms.count
            guard elementsCount > 1 else{
                print("Inspection terminated because elements count is under 1")
                return
            }
            
            let startElement = Int(UIScreen.main.bounds.minX / elementWidth)
            let endElement = Int(ceil(UIScreen.main.bounds.maxX / elementWidth) + 1)
            
            print("start : \(startElement), end: \(endElement)")
            
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
            print("texture size : \(texture?.width), \(texture?.height)")
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
            
            print("drawable size : \(currentDrawable.texture.width), \(currentDrawable.texture.height)")
            print("image size : \(image?.width), \(image?.height)")
            
            if image != nil{
                helper.spectrogram = image!
            } else{
                print("Inspection terminated because created mel-spectrogram image is nil.")
            }
            
            helper.changeProgress(progress: .RENDER_SPECTROGRAM)
        }

    }
}
