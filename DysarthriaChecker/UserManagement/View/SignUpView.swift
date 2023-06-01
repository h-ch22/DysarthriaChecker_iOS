//
//  SignUpView.swift
//  DysarthriaChecker
//
//  Created by Changjin Ha on 2023/05/01.
//

import SwiftUI

struct SignUpView: View {
    @State private var titleList = ["반가워요!", "E-Mail을 입력해주세요", "비밀번호를 입력해주세요", "비밀번호를 확인해주세요",
    "이름을 입력해주세요.", "연락처를 입력해주세요", "이용약관을 읽고 동의해주세요"]
    @State private var email = ""
    @State private var password = ""
    @State private var checkPassword = ""
    @State private var name = ""
    @State private var phone = ""
    
    @State private var acceptEULA = false
    @State private var acceptPrivacy = false
    @State private var acceptSensitive = false
    @State private var acceptHumanResearch = false
    @State private var index = 0
    @State private var isPasswordEditing: Bool = false
    @State private var alertModel : SignUpAlertModel? = nil
    @State private var showAlert = false
    @State private var showOverlay = false

    var body: some View {
        ZStack{
            Color.backgroundColor.edgesIgnoringSafeArea(.all)
            
            ScrollView{
                VStack{
                    Text(titleList[index])
                        .font(.title)
                        .fontWeight(.semibold)
                        .foregroundColor(.txt_color)
                        .transition(AnyTransition.opacity.animation(.easeInOut(duration:1)))

                    Group{
                        HStack {
                            Image(systemName: "at.circle.fill")
                            
                            TextField("E-Mail", text:$email, onEditingChanged: {(editing) in
                                if !editing{
                                    if index < 2{
                                        index += 1
                                    }
                                }
                                
                            })
                            .keyboardType(.emailAddress)
                        }
                        .padding(20)
                        .padding([.horizontal], 20)
                        .background(RoundedRectangle(cornerRadius: 10).foregroundColor(.btn_color).shadow(radius: 5)
                            .padding([.horizontal],15))
                        .isHidden(index == 0)
                        .transition(AnyTransition.opacity.animation(.easeInOut))
                        
                        Spacer().frame(height : 20)
                        
                        HStack {
                            Image(systemName: "key.fill")
                            
                            SecureField("비밀번호", text:$password, onCommit: {
                                if index < 3{
                                    index += 1
                                }
                            })
                        }
                        .padding(20)
                        .padding([.horizontal], 20)
                        .background(RoundedRectangle(cornerRadius: 10).foregroundColor(.btn_color).shadow(radius: 5)
                            .padding([.horizontal],15))
                        .isHidden(index < 2)
                        .transition(AnyTransition.opacity.animation(.easeInOut))
                        
                        Spacer().frame(height : 20)
                        
                        HStack {
                            Image(systemName: "key.fill")
                            
                            SecureField("한번 더", text:$checkPassword, onCommit: {
                                if index < 4{
                                    index += 1
                                }
                            })
                        }
                        .padding(20)
                        .padding([.horizontal], 20)
                        .background(RoundedRectangle(cornerRadius: 10).foregroundColor(.btn_color).shadow(radius: 5)
                            .padding([.horizontal],15))
                        .isHidden(index < 3)
                        .transition(AnyTransition.opacity.animation(.easeInOut))
                    }
                    
                    Group{
                        Spacer().frame(height : 20)

                        HStack {
                            Image(systemName: "person.circle.fill")
                            
                            TextField("이름", text:$name, onEditingChanged: {(editing) in
                                if !editing{
                                    if index < 5{
                                        index += 1
                                    }
                                }
                                
                            })
                        }
                        .padding(20)
                        .padding([.horizontal], 20)
                        .background(RoundedRectangle(cornerRadius: 10).foregroundColor(.btn_color).shadow(radius: 5)
                            .padding([.horizontal],15))
                        .isHidden(index < 4)
                        .transition(AnyTransition.opacity.animation(.easeInOut))
                        
                        Spacer().frame(height : 20)

                        HStack {
                            Image(systemName: "iphone.gen3.circle.fill")
                            
                            TextField("연락처", text:$phone, onEditingChanged: {(editing) in
                                if !editing{
                                    if index < 6{
                                        index += 1
                                    }
                                }
                                
                            })
                            .keyboardType(.numberPad)

                        }
                        .padding(20)
                        .padding([.horizontal], 20)
                        .background(RoundedRectangle(cornerRadius: 10).foregroundColor(.btn_color).shadow(radius: 5)
                            .padding([.horizontal],15))
                        .isHidden(index < 5)
                        .transition(AnyTransition.opacity.animation(.easeInOut))
                    }
                    
                    Group{
                        Spacer().frame(height : 20)

                        HStack{
                            CheckBox(checked : $acceptEULA)
                            Text("최종 사용권 계약서 (필수)")
                            
                            Spacer()
                        }.isHidden(index < 5)
                        
                        Spacer().frame(height : 20)

                        HStack{
                            CheckBox(checked : $acceptPrivacy)
                            Text("개인정보 수집 및 처리방침 (필수)")
                            
                            Spacer()
                        }.isHidden(index < 5)
                        
                        Spacer().frame(height : 20)

                        HStack{
                            CheckBox(checked : $acceptSensitive)
                            Text("민감정보 수집 및 처리방침 (필수)")
                            
                            Spacer()
                        }.isHidden(index < 5)
                        
                        Spacer().frame(height : 20)

                        HStack{
                            CheckBox(checked : $acceptHumanResearch)
                            Text("인간대상연구에 대한 동의서 (필수)")
                            
                            Spacer()
                        }.isHidden(index < 5)
                    }
                    
                    Button(action : {
                        if password.count < 6{
                            alertModel = .WEAK_PASSWORD
                            showAlert = true
                        } else if password != checkPassword{
                            alertModel = .PASSWORD_MISMATCH
                            showAlert = true
                        } else{
                            showOverlay = true
                        }
                    }){
                        HStack{
                            Text("다음 단계로")
                                .foregroundColor(.white)
                            
                            Image(systemName : "chevron.right")
                                .foregroundColor(.white)
                        }.padding([.vertical], 20)
                            .padding([.horizontal], 120)
                            .background(RoundedRectangle(cornerRadius: 50).foregroundColor(.accent).shadow(radius: 5))
                    }.isHidden(index < 5)
                    
                }.animation(.easeInOut).padding(20)
                    .onAppear{
                        DispatchQueue.main.asyncAfter(deadline: .now() + 1.0, execute: {
                            self.index += 1
                        })
                    }
                    .fullScreenCover(isPresented: $showOverlay){
                        Process_signUp(email: email, password: password, name: name, phone: phone, caller : .SIGN_UP)
                    }
                    .alert(isPresented : $showAlert, content : {
                        switch alertModel{
                        case .PASSWORD_MISMATCH:
                            return Alert(title: Text("비밀번호 불일치"), message: Text("비밀번호가 일치하지 않습니다."), dismissButton : .default(Text("확인")))
                            
                        case .WEAK_PASSWORD:
                            return Alert(title: Text("안전하지 않은 비밀번호"), message: Text("보안을 위해 6자리 이상의 비밀번호를 설정해주세요."), dismissButton : .default(Text("확인")))
                            
                        case .none:
                            return Alert(title: Text(""), message: Text(""), dismissButton : .default(Text("확인")))
                        }
                    })
            }
        }
    }
}

struct SignUpView_Previews: PreviewProvider {
    static var previews: some View {
        SignUpView()
    }
}
