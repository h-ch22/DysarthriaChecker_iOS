//
//  TrainingWarningView.swift
//  DysarthriaChecker
//
//  Created by Changjin Ha on 2023/05/15.
//

import SwiftUI

struct TrainingWarningView: View {
    let type : TrainTypeModel
    
    var body: some View {
        ZStack{
            Color.backgroundColor.edgesIgnoringSafeArea(.all)
            
            VStack{
                Image(systemName: "exclamationmark.bubble.fill")
                    .resizable()
                    .frame(width : 80, height : 80)
                    .foregroundColor(.orange)
                
                Text("구음장애 교정 주의사항")
                    .font(.title2)
                    .fontWeight(.bold)
                    .foregroundColor(.txt_color)
                
                Spacer().frame(height : 40)
                
                Group{
                    HStack{
                        Image(systemName: "smiley")
                            .resizable()
                            .frame(width : 40, height : 40)
                            .foregroundColor(.txt_color)
                        
                        VStack{
                            HStack {
                                Text("기본 표정 알아보기")
                                    .fontWeight(.semibold)
                                
                                Spacer()
                            }
                            
                            HStack {
                                Text("이 교정 프로세스에서 기본 표정은 입술이 평행한 상태입니다.\n입술이 평행한 상태로 유지하십시오.")
                                    .font(.caption)
                                    .fixedSize(horizontal: false, vertical: true)
                                    .foregroundColor(.gray)
                                
                                Spacer()
                            }
                        }
                    }
                    
                    Spacer().frame(height : 20)
                    
                    HStack{
                        Image(systemName: "person.crop.circle.badge.exclamationmark.fill")
                            .resizable()
                            .frame(width : 40, height : 35)
                            .foregroundColor(.txt_color)
                        
                        VStack{
                            HStack {
                                Text("본인의 의사에 따라 프로세스 진행 여부 결정하기")
                                    .fontWeight(.semibold)
                                
                                Spacer()
                            }
                            
                            HStack {
                                Text("이 교정 프로세스는 구음장애의 치료를 보장하지 않습니다.\n타인에 의해 강제로 교정 프로세스에 참여 중인 경우 본인의 의사에 따라 교정 프로세스의 진행 여부를 결정하십시오.")
                                    .font(.caption)
                                    .fixedSize(horizontal: false, vertical: true)
                                    .foregroundColor(.gray)
                                
                                Spacer()
                            }
                        }
                    }
                    
                    Spacer().frame(height : 20)
                    
                    HStack{
                        Image(systemName: "person.badge.shield.checkmark.fill")
                            .resizable()
                            .frame(width : 40, height : 40)
                            .foregroundColor(.txt_color)
                        
                        VStack{
                            HStack {
                                Text("프로세스와 관련된 중요한 안내 사항")
                                    .fontWeight(.semibold)
                                
                                Spacer()
                            }
                            
                            HStack {
                                Text("이 교정 프로세스를 통해 사용자는 구음장애 치료 상의 이익을 얻을 수 없으며, 그 어떠한 치료 및 교정 효과도 확인되지 않았습니다.\nDysarthria Checker에서는 이 프로세스를 진행함으로 사용자가 구음장애의 완전한 치료 및 교정 또는 부작용에 대한 무결성을 보장하지 않습니다.")
                                    .font(.caption)
                                    .fixedSize(horizontal: false, vertical: true)
                                    .foregroundColor(.gray)
                                
                                Spacer()
                            }
                        }
                    }
                    
                    Spacer().frame(height : 20)
                    
                    HStack{
                        Image(systemName: "camera.viewfinder")
                            .resizable()
                            .frame(width : 40, height : 40)
                            .foregroundColor(.txt_color)
                        
                        VStack{
                            HStack {
                                Text("AR 세션 이용과 관련된 주의사항")
                                    .fontWeight(.semibold)
                                
                                Spacer()
                            }
                            
                            HStack {
                                Text("부상의 위험이 있으니 AR 세션을 진행하는 동안 뒤로 걷기를 포함한 신체적 움직임이 없는 장소에서 편안한 자세로 앉아 세션을 진행하십시오.\n정신 착란 및 기타 정신적인 문제가 발생할 수 있으니 한번의 세션을 진행할 때 너무 오랜시간 동안 진행하지 말고 적당한 시간을 정해 진행하고, 되도록 보호자의 지도 하에 세션을 진행하십시오.")
                                    .font(.caption)
                                    .fixedSize(horizontal: false, vertical: true)
                                    .foregroundColor(.gray)
                                
                                Spacer()
                            }
                        }
                    }
                    
                    Spacer().frame(height : 20)

                    HStack{
                        Image(systemName: "exclamationmark.triangle.fill")
                            .resizable()
                            .frame(width : 45, height : 40)
                            .foregroundColor(.txt_color)
                        
                        VStack{
                            HStack {
                                Text("예측 가능한 부작용")
                                    .fontWeight(.semibold)
                                
                                Spacer()
                            }
                            
                            HStack {
                                Text(type == .LIP ? "일시적 또는 영구적인 입술 부위의 근육 당김/결림/통증, 성대 부위의 통증, 목에 이물질이 걸린 듯한 느낌, 일시적 또는 영구적인 성대 손상, 일시적 또는 영구적인 입술 부위의 근육 파열, 정신착란을 포함한 기타 형태의 정신적 문제" :
                                        "일시적 또는 영구적인 혀 부위의 근육 당김/결림/통증, 성대 부위의 통증, 목에 이물질이 걸린 듯한 느낌, 일시적 또는 영구적인 성대 손상, 정신착란을 포함한 기타 형태의 정신적 문제")
                                    .font(.caption)
                                    .fixedSize(horizontal: false, vertical: true)
                                    .foregroundColor(.gray)
                                
                                Spacer()
                            }
                        }
                    }
                }
            
                Group{
                    Spacer().frame(height : 20)

                    NavigationLink(destination : TrainingSessionView(type: type).navigationBarTitleDisplayMode(.inline)){
                        HStack{
                            Text("시작하기")
                                .foregroundColor(.white)
                            Image(systemName: "chevron.right")
                                .foregroundColor(.white)
                        }.padding([.vertical], 20)
                            .padding([.horizontal], 120)
                            .background(RoundedRectangle(cornerRadius: 50).foregroundColor(.accent).shadow(radius: 5))
                    }
                    
                    Spacer().frame(height : 20)
                    
                    Text("교정 프로세스를 진행하는 동안 촬영된 데이터는 서버 및 기기에 저장되지 않습니다.")
                        .font(.caption)
                        .fixedSize(horizontal: false, vertical: true)
                        .foregroundColor(.gray)
                }
                

                    
            }.padding(20)
        }
    }
}

struct TrainingWarningView_Previews: PreviewProvider {
    static var previews: some View {
        TrainingWarningView(type : .LIP)
    }
}
