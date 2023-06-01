//
//  TrainView.swift
//  DysarthriaChecker
//
//  Created by Changjin Ha on 2023/05/03.
//

import SwiftUI

struct TrainView: View {
    @State private var lip_col : [GridItem] = Array(repeating : .init(.flexible()), count:3)
    @State private var tongue_col : [GridItem] = Array(repeating: .init(.flexible()), count:3)
    
    var body: some View {
        ZStack{
            Color.backgroundColor.edgesIgnoringSafeArea(.all)
            
            ScrollView{
                VStack{
                    Group{
                        HStack{
                            Text("입술 운동")
                                .font(.title2)
                                .fontWeight(.semibold)
                            
                            Spacer()
                        }
                        
                        Spacer().frame(height : 5)
                        
                        HStack{
                            Text("하루에 3-5번 시행해주세요.")
                                .font(.caption)
                                .foregroundColor(.gray)
                            
                            Spacer()
                        }
                        
                        Spacer().frame(height : 20)
                        
                        NavigationLink(destination : TrainingWarningView()){
                            VStack {
                                LazyVGrid(columns: lip_col){
                                    ForEach((0...9), id : \.self){index in
                                        Image("lip_\(index)")
                                            .resizable()
                                            .frame(width : 60, height : 60)
                                    }
                                }
                                
                                HStack {
                                    Text("입술 운동 시작하기")
                                        .font(.title3)
                                        .fontWeight(.semibold)
                                        .foregroundColor(.txt_color)
                                    
                                    Image(systemName : "chevron.right")
                                        .foregroundColor(.txt_color)
                                }
                                
                            }.padding(20)
                                .background(RoundedRectangle(cornerRadius: 15).foregroundColor(.tutorial_color_1).opacity(0.5).shadow(radius: 5))
                        }
                    }
                    
                    
                    Spacer().frame(height : 40)
                    
                    Group{
                        HStack{
                            Text("혀 운동")
                                .font(.title2)
                                .fontWeight(.semibold)
                            
                            Spacer()
                        }
                        
                        Spacer().frame(height : 5)
                        
                        HStack{
                            Text("하루에 3-5번 시행해주세요.")
                                .font(.caption)
                                .foregroundColor(.gray)
                            
                            Spacer()
                        }
                        
                        Spacer().frame(height : 20)
                        
                        Button(action : {}){
                            VStack {
                                LazyVGrid(columns: tongue_col){
                                    ForEach((0...6), id : \.self){index in
                                        Image("tongue_\(index)")
                                            .resizable()
                                            .frame(width : 60, height : 60)
                                    }
                                }
                                
                                HStack {
                                    Text("혀 운동 시작하기")
                                        .font(.title3)
                                        .fontWeight(.semibold)
                                        .foregroundColor(.txt_color)
                                    
                                    Image(systemName : "chevron.right")
                                        .foregroundColor(.txt_color)
                                }
                                
                            }.padding(20)
                                .background(RoundedRectangle(cornerRadius: 15).foregroundColor(.tutorial_color_3).opacity(0.5).shadow(radius: 5))
                        }
                    }
                    
                }.padding(20)
            }
        }
        .animation(.easeInOut, value: 1.0)
        .navigationTitle(Text("교정 시작하기")).toolbar(content : {
            Button(action : {}){
                Image(systemName : "info.circle.fill")
            }
        })
        
    }
}

struct TrainView_Previews: PreviewProvider {
    static var previews: some View {
        TrainView()
    }
}
