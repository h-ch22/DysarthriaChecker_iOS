//
//  StatisticsView.swift
//  DysarthriaChecker
//
//  Created by 하창진 on 7/18/23.
//

import SwiftUI

struct StatisticsView: View {
    var body: some View {
        NavigationView{
            ScrollView{
                ZStack{
                    Color.backgroundColor.edgesIgnoringSafeArea(.all)
                    
                    VStack{
                        
                    }.padding(20)
                        .navigationTitle(Text("검사 기록"))
                }
            }
        }
    }
}

#Preview {
    StatisticsView()
}
