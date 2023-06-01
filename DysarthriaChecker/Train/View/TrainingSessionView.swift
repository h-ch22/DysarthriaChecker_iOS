//
//  ARView.swift
//  DysarthriaChecker
//
//  Created by Changjin Ha on 2023/05/14.
//

import SwiftUI
import RealityKit

struct TrainingSessionView: View {
    @ObservedObject var viewModel : ARViewModel = ARViewModel()
    
    var body: some View {
        ZStack{
            ARViewContainer(arViewModel: viewModel).edgesIgnoringSafeArea(.all)
            
            VStack{
                if !viewModel.sessionClear{
                    HStack{
                        Image(systemName: viewModel.isFaceDetected ? "face.smiling" : "face.dashed")
                            .padding()
                            .foregroundColor(viewModel.isFaceDetected ? .accent : .gray)
                            .background(RoundedRectangle(cornerRadius: 25).fill(.white).opacity(0.7))
                        
                        Spacer()
                        
                        Text("Session")
                        
                        Spacer()
                        
                        Text("\(String(viewModel.index)) / \(String(viewModel.scriptCount))")
                    }.padding(20)
                }

                Spacer().frame(height : 20)
                
                if !viewModel.sessionClear{
                    HStack{
                        if viewModel.remainingTime != "0"{
                            Spacer()
                            
                            Text(viewModel.remainingTime)
                                .font(.largeTitle)
                                .fontWeight(.semibold)
                                .isHidden(!(viewModel.timer?.isValid ?? false))
                            
                            Spacer()
                        } else{
                            Image(systemName: "checkmark.circle.fill")
                                .font(.largeTitle)
                                .foregroundColor(.green)
                        }

                    }.padding(20)
                    
                    Spacer()
                }

                if viewModel.sessionClear{
                    TrainSuccessView()
                } else{
                    Text(viewModel.isFaceDetected ? viewModel.currentScript : "얼굴이 인식되지 않았습니다.")
                        .padding(20)
                        .background(RoundedRectangle(cornerRadius: 15).foregroundColor(.backgroundColor).opacity(0.5))
                }

            }
        }.onDisappear{
            viewModel.stopSessionDelegate()
        }
    }
}

struct ARViewContainer : UIViewRepresentable{
    typealias UIViewType = ARView
    
    var arViewModel : ARViewModel
    
    func makeUIView(context: Context) -> ARView {
        arViewModel.startSessionDelegate()
        return arViewModel.arView
    }
    
    func updateUIView(_ uiView: ARView, context: Context) {
        
    }
}
