//
//  AboutDysarthriaView.swift
//  DysarthriaChecker
//
//  Created by 하창진 on 7/18/23.
//

import SwiftUI

struct AboutDysarthriaView: View {
    var body: some View {
        VStack{
            Image(systemName : "lightbulb.max.fill")
                .resizable()
                .frame(width : 45, height : 45)
                .aspectRatio(contentMode : .fit)
                .foregroundColor(.orange)
            
            Text("구음장애에 관하여")
                .fontWeight(.semibold)
                .foregroundColor(.txt_color)
            
            Spacer().frame(height : 5)
            
            HStack{
                Text("구음장애는 언어장애의 일종으로 중추 및 말초 신경계나 발성에 관여하는 근육이 특정 질환 등으로 인해 손상되어 발음에 장애가 생기는 증상으로, 조음 기관의 근육 손상은 호흡, 발성, 공명 등에 영향을 미쳐 말의 속도, 강도, 시간, 정확성에 문제가 발생할 수 있습니다.")
                    .font(.caption)
                    .foregroundColor(.gray)
            
            }
        }.padding(20).background(RoundedRectangle(cornerRadius: 15).foregroundColor(.btn_color).shadow(radius: 5))
    }
}

#Preview {
    AboutDysarthriaView()
}
