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
                            Image(systemName : "waveform.circle.fill")
                                .resizable()
                                .frame(width : 50, height : 50)
                                .foregroundColor(.accent)
                            
                            VStack{
                                HStack {
                                    Text("구음장애 음성 분석")
                                        .font(.title3)
                                        .fontWeight(.semibold)
                                        .foregroundColor(.txt_color)
                                    
                                    Spacer()
                                }
                                
                                HStack {
                                    Text("구음장애 음성인식 모델을 통해 구음장애를 가진 사람의 음성을 정확히 인식할 수 있습니다.")
                                        .font(.subheadline)
                                        .foregroundColor(.txt_color)

                                    Spacer()
                                }
                            }
                            
                            Spacer()
                        }
                        
                        Spacer().frame(height : 40)

                        HStack {
                            Image(systemName : "waveform.and.magnifyingglass")
                                .resizable()
                                .frame(width : 50, height : 45)
                                .foregroundColor(.accent)
                            
                            VStack{
                                HStack {
                                    Text("대략적인 구음장애 심각도 확인")
                                        .font(.title3)
                                        .fontWeight(.semibold)
                                        .foregroundColor(.txt_color)

                                    Spacer()
                                }
                                
                                HStack {
                                    Text("음성 분석 모델을 통해 구음장애의 대략적인 심각도를 확인할 수 있습니다.")
                                        .font(.subheadline)
                                        .foregroundColor(.txt_color)

                                    Spacer()
                                }
                            }
                            
                        }
                        
                        Spacer().frame(height : 40)
                        
                        HStack {
                            Image(systemName : "chart.line.uptrend.xyaxis.circle.fill")
                                .resizable()
                                .frame(width : 50, height : 50)
                                .foregroundColor(.accent)
                            
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
                        
                    }
                    
                    Spacer()
                    
                    Group{
                        Image(systemName : "person.badge.shield.checkmark.fill")
                            .resizable()
                            .frame(width : 30, height : 30)
                            .foregroundColor(.accent)
                        
                        Text("DysarthriaChecker는 구음장애의 완전한 진단 및 치료를 보장하지 않으며, 환자는 DysarthriaChecker를 통해 치료상의 이익을 얻을 수 없습니다.\n구음장애가 의심되는 경우 의사와 상담을 통해 의학적 조치를 받으십시오.")
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
                        Button("닫기"){
                            self.presentationMode.wrappedValue.dismiss()
                        }
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
