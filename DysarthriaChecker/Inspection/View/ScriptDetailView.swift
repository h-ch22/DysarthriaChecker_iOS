//
//  ScriptDetailView.swift
//  DysarthriaChecker
//
//  Created by 하창진 on 7/12/23.
//

import SwiftUI

struct ScriptDetailView: View {
    @Environment(\.presentationMode) var presentationMode
    let script : String
    
    var body: some View {
        NavigationView{
            ZStack{
                Color.backgroundColor.edgesIgnoringSafeArea(.all)
                
                ScrollView{
                    VStack{
                        Text(script)
                            .fixedSize(horizontal: false, vertical: true)
                            .lineLimit(nil)
                            .lineSpacing(15)
                    }.padding(20)
                }.navigationBarItems(leading:
                    Button(action: {
                        self.presentationMode.wrappedValue.dismiss()
                    }){
                        Image(systemName: "xmark")
                    }
                )
                .navigationTitle(Text("스크립트 전체 보기"))
            }
        }
    }
}

#Preview {
    ScriptDetailView(script: "")
}
