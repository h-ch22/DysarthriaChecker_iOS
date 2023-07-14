//
//  InspectionResultSummaryView.swift
//  DysarthriaChecker
//
//  Created by 하창진 on 7/12/23.
//

import SwiftUI

struct InspectionResultSummaryView: View {
    let result: InspectionResultSeverityModel
    
    var body: some View {
        ZStack{
            Color.backgroundColor.edgesIgnoringSafeArea(.all)
            
            VStack{
                switch result{
                case .NORMAL:
                    Image(systemName: "checkmark.circle")
                        .foregroundColor(.green)
                        .font(.title)
                    
                    Text("사용자의 음성 데이터에서 문제를 발견하지 못함")
                        .font(.title)
                        .foregroundColor(.green)
                    
                    Spacer().frame(height : 10)
                    
                    Text("사용자의 음성 데이터를 분석한 결과 Dysarthria Checker에서 해당 데이터로부터 문제를 발견하지 않았습니다.")
                        .font(.caption)
                        .foregroundColor(.gray)
                    
                case .DOUBT:
                    Image(systemName: "exclamationmark.circle.fill")
                        .foregroundColor(.orange)
                        .font(.title)
                    
                    Text("사용자의 음성 데이터에서 구음장애가 의심됨")
                        .font(.title)
                        .foregroundColor(.orange)
                    
                    Spacer().frame(height : 10)
                    
                    Text("Dysarthria Checker에서 사용자의 음성 데이터를 분석한 결과 경미한 구음장애가 의심됩니다.")
                        .font(.caption)
                        .foregroundColor(.gray)
                    
                case .CRITICAL:
                    Image(systemName: "exclamationmark.circle.fill")
                        .foregroundColor(.red)
                        .font(.title)
                    
                    Text("사용자가 구음장애를 가지고 있을 수 있음.")
                        .font(.title)
                        .foregroundColor(.red)
                    
                    Spacer().frame(height : 10)
                    
                    Text("Dysarthria Checker에서 사용자의 음성 데이터를 분석한 결과 구음장애가 의심되며, 전문의와 상담을 강력하게 권장합니다.")
                        .font(.caption)
                        .foregroundColor(.gray)
                }
            }
        }
    }
}
