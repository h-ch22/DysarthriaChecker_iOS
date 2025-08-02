//
//  InspectionMainView.swift
//  DysarthriaChecker
//
//  Created by Changjin Ha on 2023/05/03.
//

import SwiftUI

struct InspectionMainView: View {
    @Environment(\.presentationMode) var presentationMode
    
    var body: some View {
        NavigationView{
            ZStack{
                Color.backgroundColor.edgesIgnoringSafeArea(.all)
                
                VStack{
                    Spacer()
                    
                    Group{
                       
                        HStack {
                            Image(systemName : "waveform.and.magnifyingglass")
                                .font(.largeTitle)
                                .foregroundStyle(Color.accentColor)
                            
                            VStack{
                                HStack {
                                    Text("대략적인 구음장애 원인 확인")
                                        .font(.title3)
                                        .fontWeight(.semibold)
                                        .foregroundColor(.txt_color)

                                    Spacer()
                                }
                                
                                HStack {
                                    Text("음성 분석 모델을 통해 구음장애의 대략적인 원인을 추적할 수 있습니다.")
                                        .font(.subheadline)
                                        .foregroundColor(.txt_color)

                                    Spacer()
                                }
                            }
                            
                        }
                        
                        Spacer().frame(height : 40)
                        
                        HStack {
                            Image(systemName : "chart.line.uptrend.xyaxis")
                                .font(.largeTitle)
                                .foregroundStyle(Color.accentColor)
                            
                            VStack{
                                HStack {
                                    Text("검사 추이")
                                        .font(.title3)
                                        .fontWeight(.semibold)
                                        .foregroundColor(.txt_color)

                                    Spacer()
                                }
                                
                                HStack {
                                    Text("검사 기록을 기반으로 구음장애의 심각도 변화 추이를 분석할 수 있습니다.")
                                        .font(.subheadline)
                                        .foregroundColor(.txt_color)

                                    Spacer()
                                }
                            }
                            
                            Spacer()
                        }
                        
                        Spacer().frame(height : 40)
                        
                        HStack {
                            Image(systemName : "speaker.slash.fill")
                                .font(.largeTitle)
                                .foregroundStyle(Color.accentColor)
                            
                            VStack{
                                HStack {
                                    Text("조용한 장소에서 검사 진행하기")
                                        .font(.title3)
                                        .fontWeight(.semibold)
                                        .foregroundColor(.txt_color)

                                    Spacer()
                                }
                                
                                HStack {
                                    Text("이 검사를 진행할 때에는 조용한 장소에서 검사를 진행하십시오.\n잡음이 많은 장소에서 검사를 진행할 경우 정확하지 않은 결과가 산출될 수 있습니다.")
                                        .font(.subheadline)
                                        .foregroundColor(.txt_color)

                                    Spacer()
                                }
                            }
                            
                            Spacer()
                        }
                        
                    }
                    
                    Spacer()
                    
                    Group{
                        Image(systemName : "person.badge.shield.checkmark.fill")
                            .resizable()
                            .frame(width : 30, height : 30)
                            .foregroundColor(.accent)
                        
                        Text("Dysarthria Checker는 구음장애의 완전한 진단 및 치료를 보장하지 않으며, 환자는 Dysarthria Checker를 통해 치료상의 이익을 얻을 수 없습니다.\n구음장애가 의심되는 경우 전문가와 상담을 통해 의학적 조치를 받으십시오.")
                            .font(.caption)
                            .multilineTextAlignment(.center)
                            .foregroundColor(.gray)
                    }
                    
                    NavigationLink(destination : InspectionTypeSelectionView()){
                        HStack{
                            Text("시작하기")
                                .foregroundColor(.white)
                            
                            Image(systemName : "chevron.right")
                                .foregroundColor(.white)
                        }.padding([.vertical], 20)
                            .padding([.horizontal], 120)
                            .background(RoundedRectangle(cornerRadius: 50).foregroundColor(.accent).shadow(radius: 5))
                    }
                    
                }.padding(20).navigationTitle(Text("음성 분석 시작하기"))
                    .toolbar(content: {
                        ToolbarItem(placement: .topBarLeading, content: {
                            Button(action: {
                                self.presentationMode.wrappedValue.dismiss()
                            }){
                                Image(systemName: "xmark")
                            }
                        })
                    })
            }
        }
    }
}

struct InspectionMainView_Previews: PreviewProvider {
    static var previews: some View {
        InspectionMainView()
    }
}
