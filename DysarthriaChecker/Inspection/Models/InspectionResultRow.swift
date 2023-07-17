//
//  InspectionResultRow.swift
//  DysarthriaChecker
//
//  Created by 하창진 on 7/17/23.
//

import SwiftUI

struct InspectionResultRow: View {
    let disease: String
    let score: Float
    
    var body: some View {
        HStack{
            Text(disease)
                .font(.caption)
                .foregroundColor(.txt_color)
            
            Spacer()
            
            Text(String(score))
                .font(.caption)
                .foregroundColor(.accentColor)
        }
    }
}

#Preview {
    InspectionResultRow(disease : "", score : 0.0)
}
