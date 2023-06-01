//
//  TrainSuccessView.swift
//  DysarthriaChecker
//
//  Created by Changjin Ha on 2023/05/15.
//

import SwiftUI

struct TrainSuccessView: View {
    var body: some View {
        ZStack{
            Color.clear
                
            VStack{
                Spacer()
                
                Image(systemName: "checkmark.circle.fill")
                    .resizable()
                    .frame(width : 70, height : 70)
                    .foregroundColor(.green)
                
                Text("잘했어요!")
                    .font(.title)
                    .fontWeight(.semibold)
                
                Spacer()
                
                Group{
                    VStack{
                        Image(systemName: "mouth.fill")
                            .resizable()
                            .frame(width : 50, height : 25)
                            .foregroundColor(.accent)
                        
                        Text("입술 운동")
                            .font(.title2)
                            .fontWeight(.semibold)
                        
                        Spacer().frame(height : 15)
                        
                        HStack{
                            Image(systemName: "repeat")
                                .resizable()
                                .frame(width : 50, height : 50)
                                .foregroundColor(.accent)
                            
                            Text("하루에 3-5회\n반복해주세요")
                            
                            Spacer()
                        }
                        
                        Spacer().frame(height : 15)
                        
                        HStack{
                            Image(systemName: "person.fill.checkmark")
                                .resizable()
                                .frame(width : 55, height : 40)
                                .foregroundColor(.accent)
                            Text("시행 가능한 동작을\n위주로 자주해주세요")
                            
                            Spacer()
                        }
                    }.padding().background(RoundedRectangle(cornerRadius: 15).foregroundColor(.backgroundColor).opacity(0.5))

                }
                
                Spacer()
            }.padding(20)
        }
    }
}

struct TrainSuccessView_Previews: PreviewProvider {
    static var previews: some View {
        TrainSuccessView()
    }
}
