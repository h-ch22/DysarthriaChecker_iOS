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
                        NavigationLink(destination : EmptyView()){
                            HStack{
                                Text("로그인")
                                    .foregroundColor(.white)
                                
                                Image(systemName : "chevron.right")
                                    .foregroundColor(.white)
                            }.padding([.vertical], 20)
                                .padding([.horizontal], 120)
                                .background(RoundedRectangle(cornerRadius: 50).foregroundColor(.accent).shadow(radius: 5))
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

            }.navigationBarHidden(true)
        }
    }
}

struct SignInView_Previews: PreviewProvider {
    static var previews: some View {
        SignInView()
    }
}
