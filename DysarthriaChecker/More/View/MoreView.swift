//
//  MoreView.swift
//  DysarthriaChecker
//
//  Created by Changjin Ha on 2023/05/03.
//

import SwiftUI

struct MoreView: View {
    @StateObject var helper : UserManagement
    var body: some View {
        ZStack{
            Color.backgroundColor.edgesIgnoringSafeArea(.all)
            
            ScrollView{
                VStack{
                    HStack{
                        TextLogoView()
                        
                        Spacer()
                    }
                    
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
                            
                            Text(helper.userInfo?.email ?? "")
                                .font(.caption)
                                .foregroundColor(.gray)
                        }
                        
                        Spacer()
                    }.padding(20).background(RoundedRectangle(cornerRadius: 15).foregroundColor(.btn_color).shadow(radius: 2, x:0, y:2))
                    
                    Group{
                        Spacer().frame(height : 20)
                        
                        Divider()
                        
                        Spacer().frame(height : 20)
                        
                        Button(action : {}){
                            HStack{
                                Image(systemName: "checklist")
                                
                                VStack(alignment : .leading){
                                    Text("질병정보 변경")
                                        .foregroundColor(.txt_color)
                                }
                                
                                Spacer()
                            }.padding(20)
                                .background(RoundedRectangle(cornerRadius: 15).foregroundColor(.btn_color).shadow(radius: 2, x:0, y:2))
                        }
                        
                        Spacer().frame(height : 20)
                        
                        Button(action : {}){
                            HStack{
                                Image(systemName: "key.horizontal.fill")
                                
                                VStack(alignment : .leading){
                                    Text("비밀번호 변경")
                                        .foregroundColor(.txt_color)
                                }
                                
                                Spacer()
                            }.padding(20)
                                .background(RoundedRectangle(cornerRadius: 15).foregroundColor(.btn_color).shadow(radius: 2, x:0, y:2))
                        }
                        
                        Spacer().frame(height : 20)
                        
                        Button(action : {}){
                            HStack{
                                Image(systemName: "iphone.gen3")
                                
                                VStack(alignment : .leading){
                                    Text("연락처 변경")
                                        .foregroundColor(.txt_color)
                                }
                                
                                Spacer()
                            }.padding(20)
                                .background(RoundedRectangle(cornerRadius: 15).foregroundColor(.btn_color).shadow(radius: 2, x:0, y:2))
                        }
                    }
                    
                    Spacer().frame(height : 20)
                    
                    Button(action : {}){
                        HStack{
                            Image(systemName: "xmark.bin.fill")
                                                        
                            VStack(alignment : .leading){
                                Text("민감정보 삭제 요청 및 동의 철회")
                                    .foregroundColor(.txt_color)
                            }
                            
                            Spacer()
                        }.padding(20)
                        .background(RoundedRectangle(cornerRadius: 15).foregroundColor(.btn_color).shadow(radius: 2, x:0, y:2))
                    }
                    
                    Spacer().frame(height : 20)
                    
                    NavigationLink(destination : EmptyView()){
                        HStack{
                            Image(systemName: "heart.fill")
                            
                            VStack(alignment : .leading){
                                Text("피드백 허브")
                                    .foregroundColor(.txt_color)
                            }
                            
                            Spacer()
                        }.padding(20).background(RoundedRectangle(cornerRadius: 15).foregroundColor(.btn_color).shadow(radius: 2, x:0, y:2))
                    }
                    
                    Spacer().frame(height : 20)
                    
                    NavigationLink(destination : InfoView()){
                        HStack{
                            Image(systemName: "info.circle.fill")
                            
                            VStack(alignment : .leading){
                                Text("정보")
                                    .foregroundColor(.txt_color)
                            }
                            
                            Spacer()
                        }.padding(20).background(RoundedRectangle(cornerRadius: 15).foregroundColor(.btn_color).shadow(radius: 2, x:0, y:2))
                    }
                    
                    Spacer().frame(height : 20)
                    
                    HStack{
                        Button(action : {}){
                            Text("로그아웃")
                                .font(.caption)
                                .foregroundColor(.gray)
                            
                            Text(" 또는 ")
                                .font(.caption)
                                .foregroundColor(.gray)
                            
                            Button(action : {}){
                                Text("회원 탈퇴")
                                    .font(.caption)
                                    .foregroundColor(.gray)
                            }
                        }
                    }
                }
                
            }.padding(20)
                .animation(.easeInOut, value: 1.0)
        }
    }
}

struct MoreView_Previews: PreviewProvider {
    static var previews: some View {
        MoreView(helper: UserManagement())
    }
}
