//
//  TrainListModel.swift
//  DysarthriaChecker
//
//  Created by Changjin Ha on 2023/05/03.
//

import SwiftUI

struct TrainListModel: View {
    let icon : String
    let title : String
    
    var body: some View {
        VStack {
            Text("😀")
                .font(.largeTitle)
            
            Text("입 벌렸다 다물기")
                .font(.title)
                .fontWeight(.semibold)
                .foregroundColor(.white)

        }
        .padding(20)
        .background(RoundedRectangle(cornerRadius: 15).foregroundColor(.accent).shadow(radius: 5))
        
    }
}
