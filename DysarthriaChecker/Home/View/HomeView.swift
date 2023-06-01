//
//  HomeView.swift
//  DysarthriaChecker
//
//  Created by Changjin Ha on 2023/05/03.
//

import SwiftUI

struct HomeView: View {
    @StateObject var helper : UserManagement
    
    var body: some View {
        ZStack{
            Color.backgroundColor.edgesIgnoringSafeArea(.all)
            
            ScrollView{
                VStack{
                    HStack{
                        Text("안녕하세요,\n\(helper.userInfo?.name ?? "")님😆")
                            .foregroundColor(.txt_color)
                            .fontWeight(.semibold)
                        
                        Spacer()
                    }
                    
                    
                    
                }.padding(20)
            }
        }.animation(.easeInOut, value: 1.0)
    }
}

struct HomeView_Previews: PreviewProvider {
    static var previews: some View {
        HomeView(helper : UserManagement())
    }
}
