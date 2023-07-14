//
//  onModelProgressView.swift
//  DysarthriaChecker
//
//  Created by Changjin Ha on 2023/05/03.
//

import SwiftUI

struct onModelProgressView: View {
    let type: InspectionTypeModel?
    @StateObject private var helper = InspectionHelper()
    
    @State private var index = 5
    @State private var showAlert = false
    @State private var changeView = false
    @State private var loadScript = false
    @State private var showFilePicker = false
    @State private var showFileErrorAlert = false
    @State private var fileName : String? = nil
    @State private var fileURL : URL? = nil
    
    @Environment(\.presentationMode) var presentationmode
    
    var body: some View {
        ZStack{
            Color.backgroundColor.edgesIgnoringSafeArea(.all)
            
            if loadScript || type == .SEMI_FREE_SPEECH{
                VStack{
                    Spacer()
                    
                    ProgressView()
                    
                    Spacer().frame(height : 10)
                    
                    Text("Dysarthria Checker에서 검사 진행을 위한 준비 중입니다.\n잠시 기다려주십시오.")
                        .foregroundColor(.txt_color)
                        .multilineTextAlignment(.center)
                    
                    Spacer()
                }.onAppear{
                    if type != .FREE_SPEECH{
                        helper.getScripts(inspectionType: type!, count: index){result in
                            guard let result = result else{return}
                            
                            if !result{
                                showAlert = true
                            } else{
                                index = helper.scripts.count
                                changeView = true
                            }
                        }
                    } else{
                        changeView = true
                    }

                }.padding(20)
                    .alert(isPresented: $showAlert, content : {
                    return Alert(title: Text("오류"), message: Text("검사를 준비하는 중 문제가 발생했습니다.\n나중에 다시 시도하십시오."), dismissButton: .default(Text("확인")){
                        self.presentationmode.wrappedValue.dismiss()
                    })
                })
                    .fullScreenCover(isPresented: $changeView, content: {
                        onInspectionView(helper : helper, url: fileURL, all_index: index, type: type!)
                    })
            } else if !loadScript && type != .FREE_SPEECH{
                VStack{
                    Text("검사 스크립트 수 선택하기")
                        .font(.title)
                        .fontWeight(.semibold)
                        .foregroundColor(.txt_color)
                    
                    Spacer().frame(height : 10)
                    
                    Text("검사 진행 시 발화할 스크립트 수를 선택하십시오.\n최소 \(type == .WORD ? 10 : 5)개에서 최대 \(type == .WORD ? 20 : 15)개 사이의 값을 설정할 수 있습니다.")
                        .font(.caption)
                        .foregroundColor(.gray)
                        .multilineTextAlignment(.center)
                    
                    Spacer()
                    
                    if type != .WORD{
                        Stepper(value : $index, in: 5...15, step: 1){
                            Text("스크립트 수 : \(index)")
                        }
                    } else{
                        Stepper(value : $index, in: 10...20, step: 1){
                            Text("스크립트 수 : \(index)")
                        }
                    }
                    
                    Spacer()
                    
                    Button(action : {
                        if type == nil || index < 5{
                            showAlert = true
                        } else{
                            loadScript = true
                        }
                    }){
                        HStack{
                            Text("다음 단계로")
                                .foregroundColor(.white)
                            
                            Image(systemName: "chevron.right")
                                .foregroundColor(.white)
                        }.padding([.vertical], 20)
                            .padding([.horizontal], 120)
                            .background(RoundedRectangle(cornerRadius: 50).foregroundColor(.accent).shadow(radius: 5))
                        
                    }
                    
                    Spacer()
                    
                }.padding(20)
                    .alert(isPresented: $showAlert, content : {
                        return Alert(title: Text("오류"), message: Text("정확한 범위 내의 스크립트를 선택하십시오."), dismissButton: .default(Text("확인")){
                            self.presentationmode.wrappedValue.dismiss()
                        })
                    }).onAppear{
                        self.index = type == .WORD ? 10 : 5
                    }

            } else{
                VStack{
                    Text("검사를 위한 파일 불러오기")
                        .font(.title)
                        .fontWeight(.semibold)
                        .foregroundColor(.txt_color)
                    
                    Spacer().frame(height : 10)
                    
                    Text("검사에 사용할 녹음 파일(.wav) 을 불러오십시오.")
                        .font(.caption)
                        .foregroundColor(.gray)
                        .multilineTextAlignment(.center)
                    
                    Spacer()
                    
                    Text(self.fileURL == nil ? "선택된 파일 없음" : self.fileName!)
                    
                    Spacer().frame(height : 10)
                    
                    Button(action: {
                        showFilePicker = true
                    }){
                        HStack{
                            Image(systemName : "waveform")
                            Text("파일 선택")
                        }
                    }
                    
                    Spacer()
                    
                    Button(action : {
                        loadScript = true
                    }){
                        HStack{
                            Text("다음 단계로")
                                .foregroundColor(.white)
                            
                            Image(systemName: "chevron.right")
                                .foregroundColor(.white)
                        }
                            .padding([.vertical], 20)
                            .padding([.horizontal], 120)
                            .background(RoundedRectangle(cornerRadius: 50).foregroundColor(.accent).shadow(radius: 5))
                        
                    }.isHidden(fileURL == nil)
                    
                    Spacer()
                    
                }.padding(20)
                    .fileImporter(isPresented : $showFilePicker, allowedContentTypes: [.audio], allowsMultipleSelection: false, onCompletion: { result in
                        do{
                            let fileURL = try result.get()
                            
                            let name = fileURL.first?.lastPathComponent ?? ""
                            let exts = name.components(separatedBy: ".")
                            
                            if exts[exts.count-1] == "wav"{
                                self.fileName = name
                                self.fileURL = fileURL.first
                            } else{
                                self.showFileErrorAlert = true
                            }
                            
                        } catch{
                            print("Error reading file \(error.localizedDescription)")
                        }
                    })
                    .alert(isPresented: $showFileErrorAlert, content : {
                        return Alert(title : Text("파일 형식 오류"), message: Text("올바른 .wav 확장자의 파일을 선택하십시오."), dismissButton: .default(Text("확인")))
                    })
            }
            

        }
    }
}

struct onModelProgressView_Previews: PreviewProvider {
    static var previews: some View {
        onModelProgressView(type: InspectionTypeModel.WORD)
    }
}
