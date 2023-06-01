//
//  TutorialView.swift
//  DysarthriaChecker
//
//  Created by Changjin Ha on 2023/04/27.
//

import SwiftUI

struct TutorialView: View {
    @State private var index = 0
    @State private var titleList = ["반가워요!", "이 앱으로 할 수 있는 일", "이 앱으로 할 수 없는 일", "이제 시작합니다!"]
    @State private var captionList = ["시작하기 전에 주의사항에 대해 알아볼까요?",
                                      "1. 구음장애의 '대략적인' 원인 파악\n2. 구음장애의 '대략적인' 심각도 파악\n3. 구음장애의 '대략적인' 개선",
                                      "1. 구음장애의 완전한 원인 파악\n2. 구음장애의 정확한 심각도 파악\n3. 구음장애 개선 프로그램을 포함한 모든 치료상의 이익",
                                      "아래 버튼을 눌러 시작하세요!"]
    @State private var imgList = ["ic_tutorial_1", "ic_tutorial_2", "ic_tutorial_3", "ic_tutorial_4", "ic_tutorial_5"]
    
    private func getColor(index : Int) -> Color{
        switch index{
        case 0:
            return Color.tutorial_color_1
            
        case 1:
            return Color.tutorial_color_2.opacity(0.7)
            
        case 2:
            return Color.tutorial_color_3
            
        case 3:
            return Color.green.opacity(0.5)
        
        default:
            return Color.tutorial_color_1
        }
    }
    
    var body: some View {
        ZStack{
            
            getColor(index: index).edgesIgnoringSafeArea(.all)
            
            VStack{
                Spacer()

                Image(imgList[index])
                    .resizable()
                    .frame(width : 150, height : 150)
                
                Text(titleList[index])
                    .font(.largeTitle)
                    .fontWeight(.semibold)
                    .foregroundColor(.black)
                
                Spacer().frame(height : 10)
                
                Text(captionList[index])
                
                Spacer()
                
                Button(action : {
                    if index < 3{
                        index += 1
                    }
                }){
                    HStack{
                        Text(index < 3 ? "다음" : "시작하기")
                            .foregroundColor(index < 3 ? getColor(index: index) : .green)
                        Image(systemName: "chevron.right")
                            .foregroundColor(index < 3 ? getColor(index: index) : .green)
                    }.padding([.horizontal], 120)
                        .padding([.vertical], 20)
                        .background(RoundedRectangle(cornerRadius: 30).foregroundColor(.white).shadow(radius: 5))
                }
                

            }
        }.animation(.easeOut(duration: 0.5))
    }
}

struct TutorialView_Previews: PreviewProvider {
    static var previews: some View {
        TutorialView()
    }
}
