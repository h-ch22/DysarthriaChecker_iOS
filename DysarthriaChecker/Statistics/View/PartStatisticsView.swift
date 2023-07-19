//
//  PartStatisticsView.swift
//  DysarthriaChecker
//
//  Created by 하창진 on 7/19/23.
//

import SwiftUI
import Charts

struct PartStatisticsView: View {
    let type : ResultTypeModel
    let helper : UserManagement
    
    @State private var showProgress = true
    @Environment(\.presentationMode) var presentationMode

    var body: some View {
        NavigationView{
            ZStack{
                Color.backgroundColor.edgesIgnoringSafeArea(.all)
                
                VStack{
                    if showProgress{
                        Spacer()
                        
                        ProgressView()
                        
                        Spacer()
                    } else{
                        Chart{
                            switch type{
                            case .T00:
                                ForEach(helper.inspectionResults){ result in
                                    LineMark(x: .value("", InspectionHelper.convertDiseaseCodeToKorean(diseaseCode: "T00", code: result.T00?[0].label ?? "")), y: .value("", result.T00?[0].score ?? 0.0))
                                        .foregroundStyle(Color.red)
                                        .symbol(by: .value("", InspectionHelper.convertDiseaseCodeToKorean(diseaseCode: "T00", code: result.T00?[0].label ?? "")))
                                                
                                    LineMark(x: .value("", InspectionHelper.convertDiseaseCodeToKorean(diseaseCode: "T00", code: result.T00?[1].label ?? "")), y: .value("", result.T00?[1].score ?? 0.0))
                                            .foregroundStyle(Color.green)
                                            .symbol(by: .value("", InspectionHelper.convertDiseaseCodeToKorean(diseaseCode: "T00", code: result.T00?[1].label ?? "")))
                                                    
                                    LineMark(x: .value("", InspectionHelper.convertDiseaseCodeToKorean(diseaseCode: "T00", code: result.T00?[2].label ?? "")), y: .value("", result.T00?[2].score ?? 0.0))
                                                .foregroundStyle(Color.blue)
                                                .symbol(by: .value("", InspectionHelper.convertDiseaseCodeToKorean(diseaseCode: "T00", code: result.T00?[2].label ?? "")))
                                }
                                
                            case .T01:
                                ForEach(helper.inspectionResults){ result in
                                    LineMark(x: .value("", InspectionHelper.convertDiseaseCodeToKorean(diseaseCode: "T01", code: result.T01?[0].label ?? "")), y: .value("", result.T01?[0].score ?? 0.0))
                                                .foregroundStyle(Color.red)
                                                .symbol(by: .value("", InspectionHelper.convertDiseaseCodeToKorean(diseaseCode: "T01", code: result.T01?[0].label ?? "")))
                                                        
                                    LineMark(x: .value("", InspectionHelper.convertDiseaseCodeToKorean(diseaseCode: "T01", code: result.T01?[1].label ?? "")), y: .value("", result.T01?[1].score ?? 0.0))
                                                    .foregroundStyle(Color.green)
                                                    .symbol(by: .value("", InspectionHelper.convertDiseaseCodeToKorean(diseaseCode: "T01", code: result.T01?[1].label ?? "")))
                                }
                                
                            case .T02:
                                ForEach(helper.inspectionResults){ result in
                                    LineMark(x: .value("", InspectionHelper.convertDiseaseCodeToKorean(diseaseCode: "T02", code: result.T02?[0].label ?? "")), y: .value("", result.T02?[0].score ?? 0.0))
                                                        .foregroundStyle(Color.red)
                                                        .symbol(by: .value("", InspectionHelper.convertDiseaseCodeToKorean(diseaseCode: "T02", code: result.T02?[0].label ?? "")))
                                                                
                                    LineMark(x: .value("", InspectionHelper.convertDiseaseCodeToKorean(diseaseCode: "T02", code: result.T02?[1].label ?? "")), y: .value("", result.T02?[1].score ?? 0.0))
                                                            .foregroundStyle(Color.green)
                                                            .symbol(by: .value("", InspectionHelper.convertDiseaseCodeToKorean(diseaseCode: "T02", code: result.T02?[1].label ?? "")))
                                                                    
                                    LineMark(x: .value("", InspectionHelper.convertDiseaseCodeToKorean(diseaseCode: "T02", code: result.T02?[2].label ?? "")), y: .value("", result.T02?[2].score ?? 0.0))
                                                                .foregroundStyle(Color.blue)
                                                                .symbol(by: .value("", InspectionHelper.convertDiseaseCodeToKorean(diseaseCode: "T02", code: result.T02?[2].label ?? "")))
                                                                        
                                    LineMark(x: .value("", InspectionHelper.convertDiseaseCodeToKorean(diseaseCode: "T02", code: result.T02?[3].label ?? "")), y: .value("", result.T02?[3].score ?? 0.0))
                                                                    .foregroundStyle(Color.orange)
                                                                    .symbol(by: .value("", InspectionHelper.convertDiseaseCodeToKorean(diseaseCode: "T02", code: result.T02?[3].label ?? "")))
                                }
                                
                            case .T03:
                                ForEach(helper.inspectionResults){ result in
                                    LineMark(x: .value("", InspectionHelper.convertDiseaseCodeToKorean(diseaseCode: "T03", code: result.T03?[0].label ?? "")), y: .value("", result.T03?[0].score ?? 0.0))
                                                                .foregroundStyle(Color.red)
                                                                .symbol(by: .value("", InspectionHelper.convertDiseaseCodeToKorean(diseaseCode: "T03", code: result.T03?[0].label ?? "")))
                                                                        
                                    LineMark(x: .value("", InspectionHelper.convertDiseaseCodeToKorean(diseaseCode: "T03", code: result.T03?[1].label ?? "")), y: .value("", result.T03?[1].score ?? 0.0))
                                                                    .foregroundStyle(Color.green)
                                                                    .symbol(by: .value("", InspectionHelper.convertDiseaseCodeToKorean(diseaseCode: "T03", code: result.T03?[1].label ?? "")))
                                                                            
                                    LineMark(x: .value("", InspectionHelper.convertDiseaseCodeToKorean(diseaseCode: "T03", code: result.T03?[2].label ?? "")), y: .value("", result.T03?[2].score ?? 0.0))
                                                                        .foregroundStyle(Color.blue)
                                                                        .symbol(by: .value("", InspectionHelper.convertDiseaseCodeToKorean(diseaseCode: "T03", code: result.T03?[2].label ?? "")))

                                }
                            }
                        }
                    }
                }.padding(20)
            }.onAppear{
                helper.getInspectionResults(){ result in
                    guard let result = result else{return}
                    
                    showProgress = false
                }
            }
            .navigationTitle(Text("추세"))
            .navigationBarItems(trailing: Button("닫기"){
                self.presentationMode.wrappedValue.dismiss()
            })
        }

        
    }
}

#Preview {
    PartStatisticsView(type : .T00, helper: UserManagement())
}
