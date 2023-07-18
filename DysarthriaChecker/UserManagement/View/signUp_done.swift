//
//  signUp_done.swift
//  DysarthriaChecker
//
//  Created by Changjin Ha on 2023/05/02.
//

import SwiftUI

struct signUp_done: View {
    @State private var navigateToHome = false
    @State private var count = 5
    @StateObject var userManagement : UserManagement
    let timer = Timer.publish(every: 1, on: .main, in: .common).autoconnect()
    
    var body: some View {
        ZStack{
            Color.backgroundColor.edgesIgnoringSafeArea(.all)
            
            VStack{
                Spacer()
                
                Image(systemName : "checkmark.circle.fill")
                    .resizable()
                    .frame(width : 100, height : 100)
                    .foregroundColor(.green)
                
                Text("회원가입이 완료되었어요!")
                    .font(.title)
                    .fontWeight(.semibold)
                    .foregroundColor(.txt_color)
                
                Spacer().frame(height : 20)

                Text("\(count)초 후 메인 페이지로 이동해요!")
                    .font(.caption)
                    .foregroundColor(.gray)
                
                Spacer()
                
                Button(action: {
                    self.navigateToHome = true
                }){
                    HStack{
                        Text("시작하기")
                            .foregroundColor(.white)
                        Image(systemName: "chevron.right")
                            .foregroundColor(.white)
                    }.padding(20)
                    .padding([.horizontal], 100)
                    .background(RoundedRectangle(cornerRadius: /*@START_MENU_TOKEN@*/25.0/*@END_MENU_TOKEN@*/)
                                    .shadow(radius: 5)
                                    .foregroundColor(.accent))
                }
            }.fullScreenCover(isPresented : $navigateToHome){
                
            }.onReceive(timer, perform: { time in
                count -= 1
                
                if self.count <= 0{
                    self.navigateToHome = true
                }
            })
            
            .fullScreenCover(isPresented: $navigateToHome, content: {
                TabManager()
            })
        }
    }
}
