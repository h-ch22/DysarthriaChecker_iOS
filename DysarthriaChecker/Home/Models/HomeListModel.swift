//
//  HomeListModel.swift
//  DysarthriaChecker
//
//  Created by 하창진 on 7/18/23.
//

import SwiftUI

struct HomeListModel: View {
    let disease : String
    let result : String
    let point : Float
    
    var body: some View {
        VStack{
            Text(disease)
                .font(.caption)
                .foregroundColor(.gray)
            
            Spacer().frame(height : 20)
            
            Text(result)
                .fontWeight(.semibold)
                .foregroundColor(.accentColor)
            
            Spacer().frame(height : 10)
            
            Text(String(point))
                .font(.caption)
                .foregroundColor(.accentColor)

        }.frame(width : 150).padding(20)
            .background(RoundedRectangle(cornerRadius: 15).foregroundColor(.btn_color).shadow(radius: 5, x:0, y:5))
    }
}
