//
//  MoreView.swift
//  DysarthriaChecker
//
//  Created by Changjin Ha on 2023/05/03.
//

import SwiftUI

struct MoreView: View {
    @StateObject private var helper = UserManagement()
    var body: some View {
        ZStack{
            Color.backgroundColor.edgesIgnoringSafeArea(.all)
            
            ScrollView{
                VStack{
                    HStack{
                        TextLogoView()
                        
                        Spacer()
                    }
                    
                    NavigationLink(destination : ProfileView(helper : helper)){
                        HStack{
                            Image("ic_appstore_transparent")
                                .resizable()
                                .frame(width : 35, height : 35)
                                .padding(10)
                                .background(Circle().foregroundColor(.accent).opacity(0.5))
                            
                            VStack(alignment : .leading){
                                Text(helper.userInfo?.name ?? "알 수 없는 사용자")
                                    .foregroundColor(.txt_color)
                                    .fontWeight(.semibold)
                                
                                Text("프로필 보기")
                                    .font(.caption)
                                    .foregroundColor(.gray)
                            }
                            
                            Spacer()
                        }.padding(20).background(RoundedRectangle(cornerRadius: 15).foregroundColor(.btn_color).shadow(radius: 5))
                    }
                    
                    Group{
                        Spacer().frame(height : 20)
                        
                        Divider()
                        
                        Spacer().frame(height : 20)
                        
                        NavigationLink(destination : EmptyView()){
                            HStack{
                                Image(systemName: "chart.xyaxis.line")
                                    .resizable()
                                    .frame(width : 25, height : 25)
                                    .foregroundColor(.accent)
                                
                                VStack(alignment : .leading){
                                    Text("검사 추세 및 기록")
                                        .foregroundColor(.txt_color)
                                }
                                
                                Spacer()
                            }.padding(20).background(RoundedRectangle(cornerRadius: 15).foregroundColor(.btn_color).shadow(radius: 5))
                        }
                        
                        Spacer().frame(height : 20)
                        
                        NavigationLink(destination : EmptyView()){
                            HStack{
                                Image(systemName: "bell.badge.circle.fill")
                                    .resizable()
                                    .frame(width : 25, height : 25)
                                    .foregroundColor(.accent)
                                
                                VStack(alignment : .leading){
                                    Text("공지사항")
                                        .foregroundColor(.txt_color)
                                }
                                
                                Spacer()
                            }.padding(20).background(RoundedRectangle(cornerRadius: 15).foregroundColor(.btn_color).shadow(radius: 5))
                        }
                        
                        Spacer().frame(height : 20)
                        
                        NavigationLink(destination : EmptyView()){
                            HStack{
                                Image(systemName: "heart.fill")
                                    .resizable()
                                    .frame(width : 25, height : 25)
                                    .foregroundColor(.accent)
                                
                                VStack(alignment : .leading){
                                    Text("피드백 허브")
                                        .foregroundColor(.txt_color)
                                }
                                
                                Spacer()
                            }.padding(20).background(RoundedRectangle(cornerRadius: 15).foregroundColor(.btn_color).shadow(radius: 5))
                        }
                        
                        Spacer().frame(height : 20)
                        
                        NavigationLink(destination : InfoView()){
                            HStack{
                                Image(systemName: "info.circle.fill")
                                    .resizable()
                                    .frame(width : 25, height : 25)
                                    .foregroundColor(.accent)
                                
                                VStack(alignment : .leading){
                                    Text("정보")
                                        .foregroundColor(.txt_color)
                                }
                                
                                Spacer()
                            }.padding(20).background(RoundedRectangle(cornerRadius: 15).foregroundColor(.btn_color).shadow(radius: 5))
                        }
                    }
                    
                }.padding(20)
                    .animation(.easeInOut, value: 1.0)
            }
        }
    }
}

struct MoreView_Previews: PreviewProvider {
    static var previews: some View {
        MoreView()
    }
}
