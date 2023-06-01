//
//  SplashView.swift
//  DysarthriaChecker
//
//  Created by Changjin Ha on 2023/04/27.
//

import SwiftUI

struct SplashView: View {
    @State private var showSignInView = false
    @State private var showHome = false
    @State private var helper = UserManagement()
    
    var body: some View {
        NavigationView{
            ZStack{
                Color.backgroundColor.edgesIgnoringSafeArea(.all)
                
                VStack{
                    
                    Spacer()
                    
                    Image("ic_appstore_transparent")
                        .resizable()
                        .frame(width : 200, height : 200)
                    
                    TextLogoView()
                    
                    Spacer()
                    
                    ProgressView()
                }
            }.onAppear{
                if UserDefaults.standard.string(forKey: "auth_email") != nil &&
                    UserDefaults.standard.string(forKey: "auth_password") != nil{
                    let laHelper = LAHelper()
                    laHelper.authenticate(){result in
                        guard let result = result else{return}
                        
                        if result{
                            helper.signIn(email : AES256Util.decrypt(encoded: UserDefaults.standard.string(forKey: "auth_email")!), password : AES256Util.decrypt(encoded: UserDefaults.standard.string(forKey: "auth_password")!)){ result in
                                guard let result = result else{return}
                                
                                if result{
                                    showHome = true
                                } else{
                                    showSignInView = true
                                }
                            }
                        } else{
                            showSignInView = true
                        }
                    }
                    

                } else{
                    showSignInView = true
                }
            }
            .fullScreenCover(isPresented: $showSignInView){
                SignInView()
            }
            .fullScreenCover(isPresented: $showHome){
                TabManager(userManagement: helper)
            }
            .navigationBarHidden(true)
            .accentColor(.accent)
        }
    }
}

struct SplashView_Previews: PreviewProvider {
    static var previews: some View {
        SplashView()
    }
}
