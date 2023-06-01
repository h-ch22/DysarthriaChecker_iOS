//
//  Process_error.swift
//  DysarthriaChecker
//
//  Created by Changjin Ha on 2023/05/01.
//

import SwiftUI

struct Process_error: View {
    var body: some View {
        ZStack{
            Color.backgroundColor.edgesIgnoringSafeArea(.all)
            
            VStack{
                Spacer()
                
                Image(systemName : "exclamationmark.triangle.fill")
                    .resizable()
                    .frame(width : 150, height : 125)
                    .foregroundColor(.accent)
                
                Text("죄송합니다, 고객님.")
                    .font(.title)
                    .fontWeight(.semibold)
                    .foregroundColor(.txt_color)
                
                Spacer().frame(height : 10)
                
                Text("고객님의 요청을 처리하는 중 문제가 발생하였습니다.")
                
                Spacer()
            }
        }
    }
}

struct Process_error_Previews: PreviewProvider {
    static var previews: some View {
        Process_error()
    }
}
