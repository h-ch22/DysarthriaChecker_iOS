//
//  DisabledTypeCheckView.swift
//  DysarthriaChecker
//
//  Created by Changjin Ha on 2023/05/01.
//

import SwiftUI

struct DisabledTypeCheckView: View {
    @State private var date = Date()
    @State private var strokeDisabledSelection: disabledSeverityOption?
    @State private var degenerativeBrainDiseaseSelection: disabledSeverityOption?
    @State private var peripheralNeuropathySelection: disabledSeverityOption?
    @State private var otherBrainDisease: disabledSeverityOption?
    
    @State private var functionalLanguageSelection: disabledSeverityOption?
    @State private var larynxSelection: disabledSeverityOption?
    @State private var oralSelection: disabledSeverityOption?
    @State private var otherLanguageDisease: disabledSeverityOption?
    
    @State private var showOverlay = false
    @State private var showAlert = false
    @State private var alertModel : DisabledTypeCheckAlertModel? = nil
    
    let helper = UserManagement()
    
    enum disabledSeverityOption: CaseIterable, CustomStringConvertible{
        case NONE, WEAK, MEDIUM, HARD
        
        var description: String{
            switch self{
            case .NONE:
                return "없음"
                
            case .WEAK:
                return "경도"
                
            case .MEDIUM:
                return "중등"
                
            case .HARD:
                return "고도"
            }
        }
        
        var code: Int{
            switch self{
            case .NONE:
                return 0
                
            case .WEAK:
                return 1
                
            case .MEDIUM:
                return 2
                
            case .HARD:
                return 3
            }
        }
    }
    
    var body: some View {
        ZStack{
            Color.backgroundColor.edgesIgnoringSafeArea(.all)
            
            ScrollView{
                VStack{
                    Group{
                        Text("추가 정보를 제공해주세요.")
                            .font(.title)
                            .fontWeight(.semibold)
                            .foregroundColor(.txt_color)
                        
                        Spacer().frame(height : 20)
                        
                        DatePicker("생년월일", selection: $date, in: ...Date(), displayedComponents: [.date])
                        
                        Divider()
                        
                        HStack{
                            Text("귀하께서는 아래 뇌질환 중 하나 이상을 진단받은 적이 있습니까?")
                                .fontWeight(.semibold)
                            
                            Spacer()
                        }
                        
                        Spacer().frame(height : 10)
                        
                        Divider()
                        
                        Spacer().frame(height : 10)
                    }

                    Group{
                        HStack{
                            Text("뇌졸중")
                            
                            Spacer()
                        }
                        
                        RadioButtonGroup(selection : $strokeDisabledSelection,
                                         orientation: .horizonal,
                                         tags : disabledSeverityOption.allCases,
                                         button : { isSelected in
                            ZStack{
                                Circle()
                                    .foregroundColor(.gray).opacity(0.5)
                                    .frame(width : 20, height : 20)
                                    .animation(.easeInOut, value: 1.0)
                                
                                if isSelected{
                                    Circle()
                                        .foregroundColor(.accent)
                                        .frame(width : 10, height : 10)
                                        .animation(.easeInOut, value: 1.0)
                                }
                            }
                        }, label : {tag in
                            Text("\(tag.description)")
                        })
                        
                        
                        Spacer().frame(height : 10)
                        
                        HStack{
                            Text("퇴행성 뇌질환")
                            
                            Spacer()
                        }
                        
                        RadioButtonGroup(selection : $degenerativeBrainDiseaseSelection,
                                         orientation: .horizonal,
                                         tags : disabledSeverityOption.allCases,
                                         button : { isSelected in
                            ZStack{
                                Circle()
                                    .foregroundColor(.gray).opacity(0.5)
                                    .frame(width : 20, height : 20)
                                    .animation(.easeInOut, value: 1.0)
                                
                                if isSelected{
                                    Circle()
                                        .foregroundColor(.accent)
                                        .frame(width : 10, height : 10)
                                        .animation(.easeInOut, value: 1.0)
                                }
                            }
                        }, label : {tag in
                            Text("\(tag.description)")
                        })
                        
                        Spacer().frame(height : 10)
                        
                        HStack{
                            Text("말초성 뇌신경장애")
                            
                            Spacer()
                        }
                        
                        RadioButtonGroup(selection : $peripheralNeuropathySelection,
                                         orientation: .horizonal,
                                         tags : disabledSeverityOption.allCases,
                                         button : { isSelected in
                            ZStack{
                                Circle()
                                    .foregroundColor(.gray).opacity(0.5)
                                    .frame(width : 20, height : 20)
                                    .animation(.easeInOut, value: 1.0)
                                
                                if isSelected{
                                    Circle()
                                        .foregroundColor(.accent)
                                        .frame(width : 10, height : 10)
                                        .animation(.easeInOut, value: 1.0)
                                }
                            }
                        }, label : {tag in
                            Text("\(tag.description)")
                        })
                        
                        Spacer().frame(height : 10)
                        
                    }
                    
                    Group{
                        HStack{
                            Text("기타 뇌질환")
                            
                            Spacer()
                        }
                        
                        RadioButtonGroup(selection : $otherBrainDisease,
                                         orientation: .horizonal,
                                         tags : disabledSeverityOption.allCases,
                                         button : { isSelected in
                            ZStack{
                                Circle()
                                    .foregroundColor(.gray).opacity(0.5)
                                    .frame(width : 20, height : 20)
                                    .animation(.easeInOut, value: 1.0)
                                
                                if isSelected{
                                    Circle()
                                        .foregroundColor(.accent)
                                        .frame(width : 10, height : 10)
                                        .animation(.easeInOut, value: 1.0)
                                }
                            }
                        }, label : {tag in
                            Text("\(tag.description)")
                        })
                        
                        Spacer().frame(height : 20)
                        
                        Divider()
                                                                        
                        HStack{
                            Text("귀하께서는 아래 언어.청각 장애 중 하나 이상을 진단받은 적이 있습니까?")
                                .fontWeight(.semibold)
                            
                            Spacer()
                        }
                        
                        Spacer().frame(height : 10)
                        
                        Divider()
                        
                        Spacer().frame(height : 10)
                        
                        HStack{
                            Text("기능성 언어.청각 장애")
                            
                            Spacer()
                        }
                        
                        RadioButtonGroup(selection : $functionalLanguageSelection,
                                         orientation: .horizonal,
                                         tags : disabledSeverityOption.allCases,
                                         button : { isSelected in
                            ZStack{
                                Circle()
                                    .foregroundColor(.gray).opacity(0.5)
                                    .frame(width : 20, height : 20)
                                    .animation(.easeInOut, value: 1.0)
                                
                                if isSelected{
                                    Circle()
                                        .foregroundColor(.accent)
                                        .frame(width : 10, height : 10)
                                        .animation(.easeInOut, value: 1.0)
                                }
                            }
                        }, label : {tag in
                            Text("\(tag.description)")
                        })
                        
                    }
                    
                    Group{
                        Spacer().frame(height : 10)
                        
                        HStack{
                            Text("후두 장애")
                            
                            Spacer()
                        }
                        
                        RadioButtonGroup(selection : $larynxSelection,
                                         orientation: .horizonal,
                                         tags : disabledSeverityOption.allCases,
                                         button : { isSelected in
                            ZStack{
                                Circle()
                                    .foregroundColor(.gray).opacity(0.5)
                                    .frame(width : 20, height : 20)
                                    .animation(.easeInOut, value: 1.0)
                                
                                if isSelected{
                                    Circle()
                                        .foregroundColor(.accent)
                                        .frame(width : 10, height : 10)
                                        .animation(.easeInOut, value: 1.0)
                                }
                            }
                        }, label : {tag in
                            Text("\(tag.description)")
                        })
                        
                        Spacer().frame(height : 10)
                        
                        HStack{
                            Text("구강 장애")
                            
                            Spacer()
                        }
                        
                        RadioButtonGroup(selection : $oralSelection,
                                         orientation: .horizonal,
                                         tags : disabledSeverityOption.allCases,
                                         button : { isSelected in
                            ZStack{
                                Circle()
                                    .foregroundColor(.gray).opacity(0.5)
                                    .frame(width : 20, height : 20)
                                    .animation(.easeInOut, value: 1.0)
                                
                                if isSelected{
                                    Circle()
                                        .foregroundColor(.accent)
                                        .frame(width : 10, height : 10)
                                        .animation(.easeInOut, value: 1.0)
                                }
                            }
                        }, label : {tag in
                            Text("\(tag.description)")
                        })
                        
                        Spacer().frame(height : 10)
                        
                        HStack{
                            Text("기타 언어.청각 장애")
                            
                            Spacer()
                        }
                        
                        RadioButtonGroup(selection : $otherLanguageDisease,
                                         orientation: .horizonal,
                                         tags : disabledSeverityOption.allCases,
                                         button : { isSelected in
                            ZStack{
                                Circle()
                                    .foregroundColor(.gray).opacity(0.5)
                                    .frame(width : 20, height : 20)
                                    .animation(.easeInOut, value: 1.0)
                                
                                if isSelected{
                                    Circle()
                                        .foregroundColor(.accent)
                                        .frame(width : 10, height : 10)
                                        .animation(.easeInOut, value: 1.0)
                                }
                            }
                        }, label : {tag in
                            Text("\(tag.description)")
                        })
                        
                        Spacer().frame(height : 20)
                        
                    }
                    
                    Button(action: {
                        if strokeDisabledSelection?.description == nil ||
                            degenerativeBrainDiseaseSelection?.description == nil ||
                            peripheralNeuropathySelection?.description == nil ||
                            otherBrainDisease?.description == nil ||
                            functionalLanguageSelection?.description == nil ||
                            larynxSelection?.description == nil ||
                            oralSelection?.description == nil ||
                            otherLanguageDisease?.description == nil{
                            alertModel = .BLANK_SELECTION
                            showAlert = true
                        } else{
                            let isAdult = helper.calculateAge(selection: date)
                            
                            if !isAdult{
                                alertModel = .CHILD
                                showAlert = true
                            } else{
                                showOverlay = true
                            }
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
                    }
                    
                }.padding(20)
                    .alert(isPresented : $showAlert, content : {
                        switch alertModel{
                        case .BLANK_SELECTION:
                            return Alert(title: Text("공백 필드"), message: Text("모든 선택지에 답변해주세요."), dismissButton: .default(Text("확인")))
                            
                        case .CHILD:
                            return Alert(title : Text("미성년자 실험 참여"), message: Text("입력하신 생년월일에 의하면 현재 사용자는 미성년자로 추정됩니다.\n귀하께서는 미성년인 본인 또는 법률에 의하여 대리권이 부여된 법정대리인이 맞습니까?"), primaryButton: .default(Text("예")){
                                showOverlay = true
                                
                            }, secondaryButton: .default(Text("아니오")))
                            
                        case .none:
                            return Alert(title : Text(""), message: Text(""), dismissButton: .default(Text("확인")))
                        }
                    })
                    .fullScreenCover(isPresented: $showOverlay){
                        Process_signUp(strokeDisabledLevel: strokeDisabledSelection?.code,
                                       degenerativeBrainDiseaseLevel: degenerativeBrainDiseaseSelection?.code,
                                       peripheralNeuropathyLevel: peripheralNeuropathySelection?.code,
                                       otherBrainDiseaseLevel: otherBrainDisease?.code,
                                       functionalLanguageLevel: functionalLanguageSelection?.code,
                                       larynxLevel: larynxSelection?.code,
                                       oralLevel: oralSelection?.code,
                                       otherLanguageDiseaseLevel: otherLanguageDisease?.code,
                                       caller: onProgressCallerModel.DISABLED_TYPE_CHECK
                        )
                    }
                    .accentColor(.accent)
            }
        }
    }
}

struct DisabledTypeCheckView_Previews: PreviewProvider {
    static var previews: some View {
        DisabledTypeCheckView()
    }
}
