//
//  ProfileView.swift
//  DysarthriaChecker
//
//  Created by Changjin Ha on 2023/05/03.
//

import SwiftUI

struct ProfileView: View {
    @StateObject var helper : UserManagement
    var body: some View {
        ZStack{
            Color.backgroundColor.edgesIgnoringSafeArea(.all)
            
            VStack{
                Image("ic_appstore_transparent")
                    .resizable()
                    .frame(width : 100, height : 100)
                    .padding(10)
                    .background(Circle().foregroundColor(.accent).opacity(0.5).shadow(radius: 5))
                
                VStack{
                    Group{
                        Text(helper.userInfo?.name ?? "알 수 없는 사용자")
                            .foregroundColor(.txt_color)
                            .font(.title2)
                            .fontWeight(.semibold)
                        
                        Text(helper.userInfo?.email ?? "")
                            .foregroundColor(.gray)
                            .font(.caption)
                        
                        Spacer().frame(height : 20)
                        
                        Button(action : {}){
                            HStack{
                                Image(systemName: "checklist")
                                Text("질병정보 변경")
                                
                                Spacer()
                            }.padding(20)
                                .background(RoundedRectangle(cornerRadius: 15).foregroundColor(.btn_color).shadow(radius: 5))
                        }
                        
                        Spacer().frame(height : 20)
                        
                        Button(action : {}){
                            HStack{
                                Image(systemName: "key.horizontal.fill")
                                Text("비밀번호 변경")
                                
                                Spacer()
                            }.padding(20)
                                .background(RoundedRectangle(cornerRadius: 15).foregroundColor(.btn_color).shadow(radius: 5))
                        }
                        
                        Spacer().frame(height : 20)
                        
                        Button(action : {}){
                            HStack{
                                Image(systemName: "iphone.gen3")
                                Text("연락처 변경")
                                
                                Spacer()
                            }.padding(20)
                                .background(RoundedRectangle(cornerRadius: 15).foregroundColor(.btn_color).shadow(radius: 5))
                        }
                        
                        Spacer().frame(height : 20)
                        
                        Button(action : {}){
                            HStack{
                                Image(systemName: "calendar.badge.clock.rtl")
                                Text("검사 내역")
                                
                                Spacer()
                            }.padding(20)
                                .background(RoundedRectangle(cornerRadius: 15).foregroundColor(.btn_color).shadow(radius: 5))
                        }
                        
                        
                    }
                    
                    Spacer().frame(height : 20)
                    
                    Button(action : {}){
                        HStack{
                            Image(systemName: "xmark.bin.fill")
                            Text("민감정보 삭제 요청 및 동의 철회")
                            
                            Spacer()
                        }.padding(20)
                            .background(RoundedRectangle(cornerRadius: 15).foregroundColor(.btn_color).shadow(radius: 5))
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
                }.padding(20)
            }
        }
    }
}

struct ProfileView_Previews: PreviewProvider {
    static var previews: some View {
        ProfileView(helper : UserManagement())
    }
}
