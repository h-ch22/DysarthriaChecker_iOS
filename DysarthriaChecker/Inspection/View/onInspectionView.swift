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
    @State private var showParsingAlert = false
    @State private var showErrorAlert = false
    @State private var showInspectionErrorAlert = false
    @State private var showRenderErrorAlert = false
    @State private var showAllScript = false
    @State private var showRenderView = false
    
    @ObservedObject private var audioHelper = AudioRecordingHelper(numberOfSamples: 10)
    @Environment(\.presentationMode) var presentationmode
    
    let url: URL?
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
            
            if index >= all_index - 1 || type == .FREE_SPEECH{
                VStack{
                    HStack{
                        Spacer()
                        
                        Button(action: {
                            self.presentationmode.wrappedValue.dismiss()
                        }){
                            Image(systemName : "xmark.circle.fill")
                                .foregroundColor(.gray)
                        }
                    }
                    Spacer()
                    
                    Group{
                        HStack{
                            if helper.progress == nil{
                                if showParsingAlert || showErrorAlert{
                                    Image(systemName: "exclamationmark.circle.fill")
                                        .font(helper.progress == nil ? .headline : .caption)
                                        .foregroundColor(.orange)
                                } else{
                                    ProgressView()
                                }
                            } else{
                                Image(systemName: "checkmark")
                                    .font(helper.progress == nil ? .headline : .caption)
                                    .foregroundColor(.green)
                            }
                            
                            Spacer().frame(width : 5)
                            
                            Text("파일 로드")
                                .font(helper.progress == nil ? .headline : .caption)
                                .foregroundColor(helper.progress == nil ? .txt_color : .gray)
                        }
                        
                        Spacer().frame(height : 10)
                        
                        HStack{
                            if helper.progress == .LOAD_FILE{
                                if showParsingAlert || showErrorAlert{
                                    Image(systemName: "exclamationmark.circle.fill")
                                        .font(helper.progress == .LOAD_FILE ? .headline : .caption)
                                        .foregroundColor(.orange)
                                } else{
                                    ProgressView()
                                }
                            } else if helper.progress != nil{
                                Image(systemName: "checkmark")
                                    .font(helper.progress == .LOAD_FILE ? .headline : .caption)
                                    .foregroundColor(.green)
                            }
                            
                            Spacer().frame(width : 5)
                            
                            Text("음성 데이터 추출")
                                .font(helper.progress == .LOAD_FILE ? .headline : .caption)
                                .foregroundColor(helper.progress == .LOAD_FILE ? .txt_color : .gray)
                        }
                        
                        Spacer().frame(height : 10)
                        
                        HStack{
                            if helper.progress == .EXTRACT_FILE{
                                if showRenderErrorAlert{
                                    Image(systemName: "exclamationmark.circle.fill")
                                        .font(helper.progress == .EXTRACT_FILE ? .headline : .caption)
                                        .foregroundColor(.orange)
                                } else{
                                    ProgressView()
                                }
                            } else if helper.progress == .RENDER_SPECTROGRAM || helper.progress == .T00 || helper.progress == .T01 || helper.progress == .T02{
                                Image(systemName: "checkmark")
                                    .font(helper.progress == .EXTRACT_FILE ? .headline : .caption)
                                    .foregroundColor(.green)
                            }
                            
                            Spacer().frame(width : 5)
                            
                            Text("음성 데이터 렌더링")
                                .font(helper.progress == .EXTRACT_FILE ? .headline : .caption)
                                .foregroundColor(helper.progress == .EXTRACT_FILE ? .txt_color : .gray)
                        }
                        
                        Spacer().frame(height : 10)

                        HStack{
                            if helper.progress == .RENDER_SPECTROGRAM{
                                if showInspectionErrorAlert{
                                    Image(systemName: "exclamationmark.circle.fill")
                                        .font(helper.progress == .RENDER_SPECTROGRAM ? .headline : .caption)
                                        .foregroundColor(.orange)
                                } else{
                                    ProgressView()
                                }
                            } else if helper.progress == .T00 || helper.progress == .T01 || helper.progress == .T02{
                                Image(systemName: "checkmark")
                                    .font(helper.progress == .RENDER_SPECTROGRAM ? .headline : .caption)
                                    .foregroundColor(.green)
                            }
                            
                            Spacer().frame(width : 5)
                            
                            Text("통합 (T00) 검사")
                                .font(helper.progress == .RENDER_SPECTROGRAM ? .headline : .caption)
                                .foregroundColor(helper.progress == .RENDER_SPECTROGRAM ? .txt_color : .gray)
                        }
                        
                        Spacer().frame(height : 10)
                        
                        HStack{
                            if helper.progress == .T00{
                                if showInspectionErrorAlert{
                                    Image(systemName: "exclamationmark.circle.fill")
                                        .font(helper.progress == .T00 ? .headline : .caption)
                                        .foregroundColor(.orange)
                                } else{
                                    ProgressView()
                                }
                            } else if helper.progress == .T01 || helper.progress == .T02{
                                Image(systemName: "checkmark")
                                    .font(helper.progress == .T00 ? .headline : .caption)
                                    .foregroundColor(.green)
                            }
                            
                            Spacer().frame(width : 5)
                            
                            Text("뇌신경장애 (T01) 검사")
                                .font(helper.progress == .T00 ? .headline : .caption)
                                .foregroundColor(helper.progress == .T00 ? .txt_color : .gray)
                        }
                        
                        Spacer().frame(height : 10)
                        
                        HStack{
                            if helper.progress == .T01{
                                if showInspectionErrorAlert{
                                    Image(systemName: "exclamationmark.circle.fill")
                                        .font(helper.progress == .T01 ? .headline : .caption)
                                        .foregroundColor(.orange)
                                } else{
                                    ProgressView()
                                }
                            } else if helper.progress == .T02{
                                Image(systemName: "checkmark")
                                    .font(helper.progress == .T01 ? .headline : .caption)
                                    .foregroundColor(.green)
                            }
                            
                            Spacer().frame(width : 5)
                            
                            Text("언어청각장애 (T02) 검사")
                                .font(helper.progress == .T01 ? .headline : .caption)
                                .foregroundColor(helper.progress == .T01 ? .txt_color : .gray)
                        }
                        
                        Spacer().frame(height : 10)
                        
                        HStack{
                            if helper.progress == .T02{
                                if showInspectionErrorAlert{
                                    Image(systemName: "exclamationmark.circle.fill")
                                        .font(helper.progress == .T02 ? .headline : .caption)
                                        .foregroundColor(.orange)
                                } else{
                                    ProgressView()
                                }
                            } else if helper.progress == .T03{
                                Image(systemName: "checkmark")
                                    .font(helper.progress == .T02 ? .headline : .caption)
                                    .foregroundColor(.green)
                            }
                            
                            Spacer().frame(width : 5)
                            
                            Text("후두장애 (T03) 검사")
                                .font(helper.progress == .T02 ? .headline : .caption)
                                .foregroundColor(helper.progress == .T02 ? .txt_color : .gray)
                        }
                    }
                    
                    
                    Spacer()
                    
                    Group{
                        
                        if !showParsingAlert && !showErrorAlert && !showInspectionErrorAlert{
                            Text("Dysarthria Checker에서 사용자의 음성 데이터를 분석하고 있습니다.\n이 작업은 파일의 길이에 따라 수 분이 걸릴 수 있습니다.\n잠시 기다려 주십시오.")
                                .font(.caption)
                                .foregroundColor(.gray)
                                .multilineTextAlignment(.center)
                        } else{
                            Image(systemName: "exclamationmark.circle.fill")
                                .foregroundColor(.accentColor)
                            
                            Spacer().frame(height : 5)
                            
                            if showParsingAlert{
                                Text("Dysarthria Checker에서 사용자의 음성 데이터를 추출하는 중 문제가 발생하였습니다.")
                                    .font(.caption)
                                    .foregroundColor(.gray)
                                    .multilineTextAlignment(.center)
                                
                                Spacer().frame(height : 10)
                                
                                Button(action: {
                                    self.presentationmode.wrappedValue.dismiss()
                                }){
                                    HStack{
                                        Text("확인")
                                            .foregroundColor(.white)
                                        
                                        Image(systemName : "chevron.right")
                                            .foregroundColor(.white)
                                    }.padding([.vertical], 20)
                                        .padding([.horizontal], 120)
                                        .background(RoundedRectangle(cornerRadius: 50).foregroundColor(.accent).shadow(radius: 5))
                                }
                            } else if showErrorAlert{
                                Text("Dysarthria Checker에서 사용자의 음성 데이터를 저장하는 중 문제가 발생하였습니다.")
                                    .font(.caption)
                                    .foregroundColor(.gray)
                                    .multilineTextAlignment(.center)
                                
                                Spacer().frame(height : 10)

                                Button(action: {
                                    self.presentationmode.wrappedValue.dismiss()
                                }){
                                    HStack{
                                        Text("확인")
                                            .foregroundColor(.white)
                                        
                                        Image(systemName : "chevron.right")
                                            .foregroundColor(.white)
                                    }.padding([.vertical], 20)
                                        .padding([.horizontal], 120)
                                        .background(RoundedRectangle(cornerRadius: 50).foregroundColor(.accent).shadow(radius: 5))
                                }
                            } else if showRenderErrorAlert{
                                Text("Dysarthria Checker에서 사용자의 음성 데이터를 렌더링하는 중 문제가 발생하였습니다.")
                                    .font(.caption)
                                    .foregroundColor(.gray)
                                    .multilineTextAlignment(.center)
                                
                                Spacer().frame(height : 10)

                                Button(action: {
                                    self.presentationmode.wrappedValue.dismiss()
                                }){
                                    HStack{
                                        Text("확인")
                                            .foregroundColor(.white)
                                        
                                        Image(systemName : "chevron.right")
                                            .foregroundColor(.white)
                                    }.padding([.vertical], 20)
                                        .padding([.horizontal], 120)
                                        .background(RoundedRectangle(cornerRadius: 50).foregroundColor(.accent).shadow(radius: 5))
                                }
                            } else if showInspectionErrorAlert{
                                Text("Dysarthria Checker에서 사용자의 음성 데이터를 분석하는 중 문제가 발생하였습니다.")
                                    .font(.caption)
                                    .foregroundColor(.gray)
                                    .multilineTextAlignment(.center)
                                
                                Spacer().frame(height : 10)

                                Button(action: {
                                    self.presentationmode.wrappedValue.dismiss()
                                }){
                                    HStack{
                                        Text("확인")
                                            .foregroundColor(.white)
                                        
                                        Image(systemName : "chevron.right")
                                            .foregroundColor(.white)
                                    }.padding([.vertical], 20)
                                        .padding([.horizontal], 120)
                                        .background(RoundedRectangle(cornerRadius: 50).foregroundColor(.accent).shadow(radius: 5))
                                }
                                
                            }
                        }
                    }
                }.animation(.easeInOut)
                    .padding(20)
                    .alert(isPresented: $showParsingAlert, content: {
                        return Alert(title: Text("오류"), message: Text("Dysarthria Checker에서 음성 데이터를 추출하는 중 문제가 발생하였습니다."), dismissButton: .default(Text("확인")){
                            self.presentationmode.wrappedValue.dismiss()
                        })
                    }).alert(isPresented: $showErrorAlert, content: {
                        return Alert(title: Text("오류"), message: Text("Dysarthria Checker에서 음성 데이터를 저장하는 중 문제가 발생하였습니다."), dismissButton: .default(Text("확인")){
                            self.presentationmode.wrappedValue.dismiss()
                        })
                    }).alert(isPresented: $showRenderErrorAlert, content: {
                        return Alert(title: Text("오류"), message: Text("Dysarthria Checker에서 음성 데이터를 렌더링하는 중 문제가 발생하였습니다."), dismissButton: .default(Text("확인")){
                            self.presentationmode.wrappedValue.dismiss()
                        })
                    }).alert(isPresented: $showInspectionErrorAlert, content: {
                        return Alert(title: Text("오류"), message: Text("Dysarthria Checker에서 음성 데이터를 분석하는 중 문제가 발생하였습니다."), dismissButton: .default(Text("확인")){
                            self.presentationmode.wrappedValue.dismiss()
                        })
                    })
                    .fullScreenCover(isPresented: $showRenderView, content: {
                        onRenderingView(spectrograms: helper.spectrograms, elementWidth: helper.elementWidth)
                    })
                    .onAppear{
                        DispatchQueue.global(qos: .background).async{
                            audioHelper.finishRecording(){ result in
                                guard let result = result else{ return }
                                
                                if result{
                                    helper.extractMelSpectrogram(filePath: self.url){result in
                                        guard let result = result else{return}
                                        
                                        if !result{
                                            showParsingAlert = true
                                        } else{
                                            showRenderView = true
                                        }
                                    }
                                } else{
                                    showErrorAlert = true
                                }
                            }
                        }
                        
                    }
            } else{
                VStack{
                    Text(type == .SEMI_FREE_SPEECH ? "다음 질문에 답해보세요\n" : "다음과 같이 말해보세요\n")
                        .font(.title)
                        .fontWeight(.semibold)
                        .multilineTextAlignment(.center)
                        .foregroundColor(.txt_color)
                    
                    Text("\(helper.scripts[index])")
                        .font(.title)
                        .fontWeight(.semibold)
                        .multilineTextAlignment(.center)
                        .lineLimit(3)
                        .foregroundColor(.accent)
                        .padding(5)
                    
                    if type == .PARAGRAPH{
                        Spacer().frame(height : 10)
                        
                        HStack{
                            Spacer()
                            
                            Button(action: {
                                showAllScript = true
                            }){
                                HStack{
                                    Text("스크립트 전체보기")
                                        .font(.caption)
                                        .foregroundColor(.gray)
                                    
                                    Image(systemName : "chevron.right")
                                        .font(.caption)
                                        .foregroundStyle(.gray)
                                }
                            }
                        }
                    }
                    
                    if type == .SEMI_FREE_SPEECH{
                        Spacer().frame(height : 10)
                        
                        Text("다음과 같은 형식으로 말하세요 : \(helper.speech_examples[index])")
                            .font(.caption)
                            .foregroundColor(.gray)
                    }
                    
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
                    
                    if type != .SEMI_FREE_SPEECH && type != .FREE_SPEECH{
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
                                Text("스크립트 새로고침")
                            }
                        }
                    }
                    
                    
                }.padding(20)
                    .overlay(ProcessView().isHidden(!showOverlay))
                    .sheet(isPresented: $showAllScript, content: {
                        ScriptDetailView(script: helper.scripts[index])
                    })
            }
            
            
        }
    }
}

#Preview {
    onInspectionView(helper : InspectionHelper(), url: nil, all_index: 0, type: InspectionTypeModel.WORD)
}
