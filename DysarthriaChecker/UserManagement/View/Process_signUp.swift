//
//  Process_signUp.swift
//  DysarthriaChecker
//
//  Created by Changjin Ha on 2023/05/01.
//

import SwiftUI

struct Process_signUp: View {
    var email : String? = nil
    var password : String? = nil
    var name : String? = nil
    var phone : String? = nil
    
    var strokeDisabledLevel : Int? = nil
    var degenerativeBrainDiseaseLevel : Int? = nil
    var peripheralNeuropathyLevel : Int? = nil
    var otherBrainDiseaseLevel : Int? = nil
    var functionalLanguageLevel : Int? = nil
    var larynxLevel : Int? = nil
    var oralLevel : Int? = nil
    var otherLanguageDiseaseLevel : Int? = nil
    
    let caller : onProgressCallerModel
    
    @State private var helper = UserManagement()
    @State private var showError = false
    @State private var showAdditionalInfo = false
    @State private var showCompleteView = false
    
    var body: some View {
        ZStack{
            Color.backgroundColor.edgesIgnoringSafeArea(.all)
            
            VStack{
                Spacer()
                
                Image("ic_appstore_transparent")
                    .resizable()
                    .frame(width : 150, height : 150)
                
                TextLogoView()
                
                Spacer().frame(height : 5)
                
                Text("고객님의 요청을 처리하고 있습니다.\n잠시 기다려주세요!")
                    .foregroundColor(.gray)
                    .multilineTextAlignment(.center)
                    .font(.caption)
                
                Spacer()
                
                ProgressView()
                
                Spacer().frame(height : 10)
                
                Text("네트워크 상태에 따라 최대 1분정도 소요될 수 있어요.")
                    .foregroundColor(.gray)
                    .font(.caption)
            }.onAppear{
                if caller == .SIGN_UP{
                    helper.signUp(email: email!, password: password!, name: name!, phone: phone!){result in
                        guard let result = result else{return}
                        
                        if result{
                            showAdditionalInfo = true
                        } else{
                            showError = true
                        }
                    }
                } else if caller == .DISABLED_TYPE_CHECK{
                    helper.updateDisabledData(strokeDisabledLevel: strokeDisabledLevel ?? 0, degenerativeBrainDiseaseLevel: degenerativeBrainDiseaseLevel ?? 0, peripheralNeuropathyLevel: peripheralNeuropathyLevel ?? 0, otherBrainDiseaseLevel: otherBrainDiseaseLevel ?? 0, funtionalLanguageLevel: functionalLanguageLevel ?? 0, larynxLevel: larynxLevel ?? 0, oralLevel: oralLevel ?? 0, otherLanguageDiseaseLevel: otherLanguageDiseaseLevel ?? 0){result in
                        guard let result = result else{return}
                        
                        if result{
                            showCompleteView = true
                        } else{
                            showError = true
                        }
                    }
                }

            }
            .fullScreenCover(isPresented: $showError){
                Process_error()
            }.fullScreenCover(isPresented : $showAdditionalInfo){
                DisabledTypeCheckView()
            }.fullScreenCover(isPresented: $showCompleteView){
                signUp_done(userManagement: helper)
            }
        }
    }
}
