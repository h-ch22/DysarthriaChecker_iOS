//
//  onModelProgressView.swift
//  DysarthriaChecker
//
//  Created by Changjin Ha on 2023/05/03.
//

import SwiftUI

struct onModelProgressView: View {
    let type: InspectionTypeModel?
    @StateObject private var helper = InspectionHelper()
    
    @State private var index = 5
    @State private var showAlert = false
    @State private var changeView = false
    
    @Environment(\.presentationMode) var presentationmode
    
    var body: some View {
        ZStack{
            Color.backgroundColor.edgesIgnoringSafeArea(.all)
            
            VStack{
                Text("검사 샘플 수 선택하기")
                    .font(.title)
                    .fontWeight(.semibold)
                    .foregroundColor(.txt_color)
                
                Spacer().frame(height : 10)
                
                Text("검사 진행 시 발화할 샘플 수를 선택하십시오.\n최소 5개에서 최대 10개 사이의 값을 설정할 수 있습니다.")
                    .font(.caption)
                    .foregroundColor(.gray)
                    .multilineTextAlignment(.center)
                
                Spacer()
                
                Stepper(value : $index, in: 5...10, step: 1){
                    Text("문장 수 : \(index)")
                }
                
                Spacer()
                
                Button(action : {
                    if type == nil || index < 5{
                        showAlert = true
                    } else{
                        helper.getScripts(inspectionType: type!, count: index){result in
                            guard let result = result else{return}
                            
                            if !result{
                                showAlert = true
                            } else{
                                changeView = true
                            }
                        }
                    }
                }){
                    HStack{
                        Text("다음 단계로")
                            .foregroundColor(.white)
                        
                        Image(systemName: "chevron.right")
                            .foregroundColor(.white)
                    }.padding([.vertical], 20)
                        .padding([.horizontal], 120)
                        .background(RoundedRectangle(cornerRadius: 50).foregroundColor(.accent).shadow(radius: 5))
                    
                }
                
                Spacer()
                
            }.padding(20)
                .alert(isPresented: $showAlert, content : {
                    return Alert(title: Text("오류"), message: Text("검사를 준비하는 중 문제가 발생했습니다.\n나중에 다시 시도하십시오."), dismissButton: .default(Text("확인")){
                        self.presentationmode.wrappedValue.dismiss()
                    })
                })
                .fullScreenCover(isPresented: $changeView, content: {
                    onInspectionView(helper : helper, all_index: index, type: type!)
                })
        }
    }
}

struct onModelProgressView_Previews: PreviewProvider {
    static var previews: some View {
        onModelProgressView(type: InspectionTypeModel.WORD)
    }
}
