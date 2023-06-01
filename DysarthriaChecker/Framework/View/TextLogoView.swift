//
//  TextLogoView.swift
//  DysarthriaChecker
//
//  Created by Changjin Ha on 2023/04/27.
//

import SwiftUI

struct TextLogoView: View {
    var body: some View {
        HStack {
            Text("Dysarthria")
                .font(.title2)
                .fontWeight(.semibold)
                .foregroundColor(.txt_color)
            
            Text("Checker")
                .font(.title2)
                .foregroundColor(.txt_color)
        }
    }
}

struct TextLogoView_Previews: PreviewProvider {
    static var previews: some View {
        TextLogoView()
    }
}
