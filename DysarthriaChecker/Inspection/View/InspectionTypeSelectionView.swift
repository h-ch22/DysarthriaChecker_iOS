//
//  InspectionTypeSelectionView.swift
//  DysarthriaChecker
//
//  Created by Changjin Ha on 2023/05/03.
//

import SwiftUI

struct InspectionTypeSelectionView: View {
    @State private var selectedType : InspectionTypeModel? = nil
    
    var body: some View {
        ZStack{
            Color.backgroundColor.edgesIgnoringSafeArea(.all)
            
            ScrollView{
                VStack{
                    Text("아래 옵션 중 하나를 선택해 검사를 진행하세요.")
                    
                    Spacer().frame(height : 40)
                    
                    Group{
                        Button(action : {
                            selectedType = .WORD
                        }){
                            HStack{
                                Image(systemName : "textformat.alt")
                                    .resizable()
                                    .frame(width : 25, height : 15)
                                    .foregroundColor(selectedType == .WORD ? .white : .txt_color)
                                
                                Spacer().frame(width : 15)
                                
                                VStack{
                                    HStack {
                                        Text("단어")
                                            .font(.title2)
                                            .fontWeight(.semibold)
                                        .foregroundColor(selectedType == .WORD ? .white : .txt_color)
                                        
                                        Spacer()
                                    }
                                    
                                    HStack {
                                        Text("짧은 단어로 검사를 진행합니다.\n장애의 정도가 매우 심각하거나 소통이 매우 힘든 경우 이 옵션을 선택하십시오.")
                                            .font(.subheadline)
                                            .foregroundColor(selectedType == .WORD ? .white : .txt_color)
                                            .multilineTextAlignment(.leading)
                                        
                                        Spacer()
                                    }
                                }
                                
                                Spacer()
                                
                                Image(systemName: "chevron.right")
                                    .foregroundColor(selectedType == .WORD ? .white : .txt_color)
                            }.padding(20).background(RoundedRectangle(cornerRadius: 15).foregroundColor(selectedType == .WORD ? .accent : .btn_color).shadow(radius : 5))
                        }
                        
                        Spacer().frame(height : 20)
                        
                        Button(action : {
                            selectedType = .SENTENCE
                        }){
                            HStack{
                                Image(systemName : "doc.text.fill")
                                    .resizable()
                                    .frame(width : 25, height : 30)
                                    .foregroundColor(selectedType == .SENTENCE ? .white : .txt_color)
                                
                                Spacer().frame(width : 15)
                                
                                VStack{
                                    HStack {
                                        Text("문장")
                                            .font(.title2)
                                            .fontWeight(.semibold)
                                        .foregroundColor(selectedType == .SENTENCE ? .white : .txt_color)
                                        
                                        Spacer()
                                    }
                                    
                                    HStack {
                                        Text("문장을 읽어 검사를 진행합니다.\n일반적인 대화가 가능한 경우 이 옵션을 선택하십시오. 이 옵션은 대부분의 사람들에게 권장됩니다.")
                                            .font(.subheadline)
                                            .foregroundColor(selectedType == .SENTENCE ? .white : .txt_color)
                                            .multilineTextAlignment(.leading)
                                        
                                        Spacer()
                                    }
                                }
                                
                                Spacer()
                                
                                Image(systemName: "chevron.right")
                                    .foregroundColor(selectedType == .SENTENCE ? .white : .txt_color)
                            }.padding(20).background(RoundedRectangle(cornerRadius: 15).foregroundColor(selectedType == .SENTENCE ? .accent : .btn_color).shadow(radius : 5))
                        }
                        
                        Spacer().frame(height : 20)
                        
                        Button(action : {
                            selectedType = .PARAGRAPH
                        }){
                            HStack{
                                Image(systemName : "text.book.closed.fill")
                                    .resizable()
                                    .frame(width : 25, height : 30)
                                    .foregroundColor(selectedType == .PARAGRAPH ? .white : .txt_color)
                                
                                Spacer().frame(width : 15)
                                
                                VStack{
                                    HStack {
                                        Text("문단")
                                            .font(.title2)
                                            .fontWeight(.semibold)
                                        .foregroundColor(selectedType == .PARAGRAPH ? .white : .txt_color)
                                        
                                        Spacer()
                                    }
                                    
                                    HStack {
                                        Text("문단 단위로 검사를 진행합니다.\n일상생활에서 소통에 큰 불편함이 없는 경우 이 옵션을 선택하십시오.")
                                            .font(.subheadline)
                                            .foregroundColor(selectedType == .PARAGRAPH ? .white : .txt_color)
                                            .multilineTextAlignment(.leading)
                                        
                                        Spacer()
                                    }
                                }
                                
                                Spacer()
                                
                                Image(systemName: "chevron.right")
                                    .foregroundColor(selectedType == .PARAGRAPH ? .white : .txt_color)
                            }.padding(20).background(RoundedRectangle(cornerRadius: 15).foregroundColor(selectedType == .PARAGRAPH ? .accent : .btn_color).shadow(radius : 5))
                        }
                        
                        Spacer().frame(height : 20)
                        
                        Button(action : {
                            selectedType = .SEMI_FREE_SPEECH
                        }){
                            HStack{
                                Image(systemName : "text.bubble.fill")
                                    .resizable()
                                    .frame(width : 25, height : 25)
                                    .foregroundColor(selectedType == .SEMI_FREE_SPEECH ? .white : .txt_color)
                                
                                Spacer().frame(width : 15)
                                
                                VStack{
                                    HStack {
                                        Text("준자유발화")
                                            .font(.title2)
                                            .fontWeight(.semibold)
                                        .foregroundColor(selectedType == .SEMI_FREE_SPEECH ? .white : .txt_color)
                                        
                                        Spacer()
                                    }
                                    
                                    HStack {
                                        Text("자유발화에 준하는 문장으로 검사를 진행합니다.\n장애의 정도가 경미하다고 판단되며, 쌍방간 의사소통이 원활한 경우 이 옵션을 선택하십시오.")
                                            .font(.subheadline)
                                            .foregroundColor(selectedType == .SEMI_FREE_SPEECH ? .white : .txt_color)
                                            .multilineTextAlignment(.leading)
                                        
                                        Spacer()
                                    }
                                }
                                
                                Spacer()
                                
                                Image(systemName: "chevron.right")
                                    .foregroundColor(selectedType == .SEMI_FREE_SPEECH ? .white : .txt_color)
                            }.padding(20).background(RoundedRectangle(cornerRadius: 15).foregroundColor(selectedType == .SEMI_FREE_SPEECH ? .accent : .btn_color).shadow(radius : 5))
                        }
                        
                        Spacer().frame(height : 20)
                        
                        Button(action : {
                            selectedType = .FREE_SPEECH
                        }){
                            HStack{
                                Image(systemName : "bubble.left.and.bubble.right.fill")
                                    .resizable()
                                    .frame(width : 25, height : 20)
                                    .foregroundColor(selectedType == .FREE_SPEECH ? .white : .txt_color)
                                
                                Spacer().frame(width : 15)
                                
                                VStack{
                                    HStack {
                                        Text("자유발화")
                                            .font(.title2)
                                            .fontWeight(.semibold)
                                        .foregroundColor(selectedType == .FREE_SPEECH ? .white : .txt_color)
                                        
                                        Spacer()
                                    }
                                    
                                    HStack {
                                        Text("자유로운 대화로 검사를 진행합니다.\n화면에 표시되는 글자를 읽기 어려워 이미 녹음된 파일이 있는 경우 이 옵션을 선택하십시오.")
                                            .font(.subheadline)
                                            .foregroundColor(selectedType == .FREE_SPEECH ? .white : .txt_color)
                                            .multilineTextAlignment(.leading)
                                        
                                        Spacer()
                                    }
                                }
                                
                                Spacer()
                                
                                Image(systemName: "chevron.right")
                                    .foregroundColor(selectedType == .FREE_SPEECH ? .white : .txt_color)
                            }.padding(20).background(RoundedRectangle(cornerRadius: 15).foregroundColor(selectedType == .FREE_SPEECH ? .accent : .btn_color).shadow(radius : 5))
                        }
                    }
                    
                    Spacer().frame(height : 40)
                    
                    NavigationLink(destination : onModelProgressView(type: selectedType)){
                        HStack{
                            Text("다음 단계로")
                                .foregroundColor(.white)
                            
                            Image(systemName : "chevron.right")
                                .foregroundColor(.white)
                        }.padding([.vertical], 20)
                            .padding([.horizontal], 120)
                            .background(RoundedRectangle(cornerRadius: 50).foregroundColor(.accent).shadow(radius: 5))
                            .isHidden(selectedType == nil)
                    }

                }.animation(.easeInOut, value: 1.0).navigationTitle(Text("검사 타입 선택"))
                    .padding(20)
            }
            

        }
    }
}

struct InspectionTypeSelectionView_Previews: PreviewProvider {
    static var previews: some View {
        InspectionTypeSelectionView()
    }
}
