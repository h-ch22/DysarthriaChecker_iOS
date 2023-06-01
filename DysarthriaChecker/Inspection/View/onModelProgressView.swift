//
//  onModelProgressView.swift
//  DysarthriaChecker
//
//  Created by Changjin Ha on 2023/05/03.
//

import SwiftUI

struct onModelProgressView: View {
    var body: some View {
        ZStack{
            Color.backgroundColor.edgesIgnoringSafeArea(.all)
            
            VStack{
                ProgressView()
                
                Spacer().frame(height : 20)
                
                Text("Dysarthria Checker에서 검사를 진행하기 위해 준비하고 있습니다.\n잠시 기다려주십시오.")
                    .font(.caption)
                    .foregroundColor(.gray)
                    .multilineTextAlignment(.center)
            }.padding(20)
        }
    }
}

struct onModelProgressView_Previews: PreviewProvider {
    static var previews: some View {
        onModelProgressView()
    }
}
