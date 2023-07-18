//
//  SignInView.swift
//  DysarthriaChecker
//
//  Created by Changjin Ha on 2023/04/27.
//

import SwiftUI

struct SignInView: View {
    @State private var email = ""
    @State private var password = ""
    @State private var showAlert = false
    @State private var showHome = false
    @State private var showOverlay = false
    
    @StateObject private var helper = UserManagement()
    
    var body: some View {
        NavigationView{
            ZStack{
                Color.backgroundColor.edgesIgnoringSafeArea(.all)
                
                VStack{
                    Spacer()
                    
                    Image("ic_appstore_transparent")
                        .resizable()
                        .frame(width : 150, height : 150)
                    
                    TextLogoView()
                    
                    Spacer().frame(height : 5)
                    
                    Text("계속 진행하려면 로그인을 해주세요.")
                        .font(.caption)
                        .foregroundColor(.gray)
                    
                    Spacer().frame(height : 30)
                    
                    Group{
                        HStack {
                            Image(systemName: "at.circle.fill")
                            
                            TextField("E-Mail", text:$email)
                        }
                        .foregroundColor(Color.txt_color)
                        .padding(20)
                        .padding([.horizontal], 20)
                        .background(RoundedRectangle(cornerRadius: 10).foregroundColor(.btn_color).shadow(radius: 5)
                                        .padding([.horizontal],15))
                        
                        Spacer().frame(height : 20)
                        
                        HStack {
                            Image(systemName: "key.fill")
                            SecureField("비밀번호", text:$password)
                        }
                        .foregroundColor(Color.txt_color)
                        .padding(20)
                        .padding([.horizontal], 20)
                        .background(RoundedRectangle(cornerRadius: 10).foregroundColor(.btn_color).shadow(radius: 5)
                                        .padding([.horizontal],15))
                    }
                    
                    Spacer().frame(height : 20)
                    
                    Group{
                        Button(action : {
                            showOverlay = true
                            helper.signIn(email: email, password: password){result in
                                guard let result = result else{
                                    return
                                }
                                
                                if result{
                                    showOverlay = false
                                    showHome = true
                                } else{
                                    showOverlay = false
                                    showAlert = true
                                }
                            }
                        }){
                            HStack{
                                Text("로그인")
                                    .foregroundColor(.white)
                                
                                Image(systemName : "chevron.right")
                                    .foregroundColor(.white)
                            }.padding([.vertical], 20)
                                .padding([.horizontal], 120)
                                .background(RoundedRectangle(cornerRadius: 50).foregroundColor(.accent).shadow(radius: 5))
                                .disabled(email == "" || password == "")
                        }
                        
                        Spacer().frame(height : 20)
                        
                        HStack{
                            NavigationLink(destination : EmptyView()){
                                Text("비밀번호 재설정")
                            }
                            
                            Spacer()
                            
                            NavigationLink(destination : SignUpView()){
                                Text("회원가입")
                            }
                        }
                        
                        Spacer().frame(height : 20)
                        
                        Text("© 2023 Ha Changjin,\nAll Rights Reserved.")
                            .font(.caption)
                            .multilineTextAlignment(.center)
                            .foregroundColor(.gray)
                    }
                    
                    Spacer()
                    
                }.padding(20)
                    .alert(isPresented: $showAlert, content : {
                        return Alert(title: Text("오류"), message: Text("로그인 처리 중 문제가 발생했습니다.\n네트워크 상태를 확인하거나, 입력한 정보가 일치하는지 확인하십시오."), dismissButton: .default(Text("확인")))
                    })
                    .fullScreenCover(isPresented: $showHome, content: {
                        TabManager()
                    })
                    .overlay(ProcessView().isHidden(!showOverlay))

            }.navigationBarHidden(true)
        }
    }
}

struct SignInView_Previews: PreviewProvider {
    static var previews: some View {
        SignInView()
    }
}
