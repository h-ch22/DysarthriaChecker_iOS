//
//  onInspectionView.swift
//  DysarthriaChecker
//
//  Created by 하창진 on 2023/07/06.
//

import SwiftUI

struct onInspectionView: View {
    @StateObject var helper : InspectionHelper
    @State private var showOverlay = false
    @State private var index = 0
    @State private var showAlert = false
    
    @ObservedObject private var audioHelper = AudioRecordingHelper(numberOfSamples: 10)
    @Environment(\.presentationMode) var presentationmode

    let all_index: Int
    let type: InspectionTypeModel
    
    private func normalizeSoundLevel(level: Float) -> CGFloat {
        let level = max(0.2, CGFloat(level) + 50) / 2
        
        return CGFloat(level * (300 / 25))
    }
    
    private func getAnimationSpeed(index: Int) -> Double{
        switch index{
        case 0:
            return 2.5
            
        case 1:
            return 1.9
            
        case 2:
            return 2.1
            
        case 3:
            return 2.3
            
        case 4:
            return 1.7
            
        case 5:
            return 1.6
            
        case 6:
            return 1.4
            
        case 7:
            return 1.2
            
        case 8:
            return 1.0
            
        case 9:
            return 1.3
            
        case 10:
            return 1.5
            
        default:
            return 1.0
            
        }
    }
    
    private var animation: Animation{
        return .linear(duration: 0.5).repeatForever()
    }

    var body: some View {
        ZStack{
            Color.backgroundColor.edgesIgnoringSafeArea(.all)
            
            if index >= all_index - 1{
                VStack{
                    Spacer()
                    
                    ProgressView()
                    
                    Spacer().frame(height : 20)
                    
                    Text("Dysarthria Checker에서 음성 데이터를 분석하고 있습니다.\n잠시 기다려 주십시오.")
                        .foregroundColor(.txt_color)
                        .multilineTextAlignment(.center)
                    
                    Spacer()
                    
                }.padding(20)
                    .onAppear{
                        audioHelper.finishRecording(){ result in
                            guard let result = result else{ return }
                            
                            if result{
                                helper.extractMFCC(){result in
                                    guard let result = result else{return}
                                    
                                    if !result{
                                        showAlert = true
                                    }
                                }
                            } else{
                                showAlert = true
                            }
                        }
                    }.alert(isPresented: $showAlert, content: {
                        return Alert(title: Text("오류"), message: Text("Dysarthria Checker에서 음성 데이터를 추출하는 중 문제가 발생하였습니다."), dismissButton: .default(Text("확인")){
                            self.presentationmode.wrappedValue.dismiss()
                        })
                    })
            } else{
                VStack{
                    Text("다음과 같이 말해보세요\n")
                        .font(.title)
                        .fontWeight(.semibold)
                        .multilineTextAlignment(.center)
                        .foregroundColor(.txt_color)
                    
                    Text("\(helper.scripts[index])")
                        .font(.title)
                        .fontWeight(.semibold)
                        .multilineTextAlignment(.center)
                        .foregroundColor(.accent)
                        .padding(5)
                    
                    Spacer()
                    
                    HStack(spacing: 12){
                        ForEach(audioHelper.soundSamples.indices, id: \.self){ index in
                            AudioSpectrumView(value: self.normalizeSoundLevel(level: audioHelper.soundSamples[index]))
                                .animation(animation.speed(getAnimationSpeed(index: index)), value: true)
                        }
                    }.frame(width : 200)
                    
                    Spacer()
                    
                    Button(action : {
                        if index < all_index - 1{
                            index += 1
                        }
                    }){
                        HStack{
                            Text(index < all_index-1 ? "다음" : "검사 종료")
                                .foregroundColor(.white)
                            
                            Image(systemName : "chevron.right")
                                .foregroundColor(.white)
                        }.padding([.vertical], 20)
                            .padding([.horizontal], 120)
                            .background(RoundedRectangle(cornerRadius: 50).foregroundColor(.accent).shadow(radius: 5))
                    }
                    
                    Spacer().frame(height : 15)
                    
                    Button(action: {
                        showOverlay = true
                        helper.refreshScript(type: type, index: index){result in
                            guard let result = result else{return}
                            
                            if result{
                                showOverlay = false
                            }
                        }
                    }){
                        HStack{
                            Image(systemName : "arrow.clockwise.circle.fill")
                            Text("단어 새로고침")
                        }
                    }
                }.padding(20)
                .overlay(ProcessView().isHidden(!showOverlay))
            }
            

        }
    }
}

#Preview {
    onInspectionView(helper : InspectionHelper(), all_index: 0, type: InspectionTypeModel.WORD)
}
