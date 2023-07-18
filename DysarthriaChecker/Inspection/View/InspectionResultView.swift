//
//  InspectionResultView.swift
//  DysarthriaChecker
//
//  Created by 하창진 on 7/17/23.
//

import SwiftUI
import AVKit

struct InspectionResultView: View {
    @Environment(\.presentationMode) var presentationmode
    @StateObject var helper : InspectionHelper
    
    let result_T00 : [PredictResult]
    let result_T01 : [PredictResult]
    let result_T02 : [PredictResult]
    let result_T03 : [PredictResult]

    var body: some View {
        NavigationView{
            ZStack{
                Color.backgroundColor.edgesIgnoringSafeArea(.all)
                
                ScrollView{
                    VStack{
                        Image(systemName : "checkmark.circle.fill")
                            .resizable()
                            .frame(width : 80, height : 80)
                            .foregroundColor(.green)
                        
                        Text("Dysarthria Checker에서 사용자의 음성 데이터 분석을 완료하였습니다.")
                            .fontWeight(.semibold)
                            .multilineTextAlignment(.center)
                            .foregroundColor(.txt_color)
                                                
                        Spacer().frame(height : 40)

                        Group{
                            HStack{
                                Text("통합 (T00) 검사 결과")
                                    .fontWeight(.semibold)
                                    .foregroundColor(.txt_color)
                                
                                Spacer()
                                
                                Text(InspectionHelper.convertDiseaseCodeToKorean(diseaseCode: "T00", code: result_T00.first?.label ?? ""))
                                    .foregroundColor(.accent)
                                    .fontWeight(.semibold)
                            }
                            
                            Spacer().frame(height : 10)
                            
                            Divider()
                            
                            Spacer().frame(height : 10)

                            VStack{
                                InspectionResultRow(disease : InspectionHelper.convertDiseaseCodeToKorean(diseaseCode: "T00", code: result_T00[0].label), score : result_T00[0].score)
                                
                                Spacer().frame(height : 10)

                                InspectionResultRow(disease : InspectionHelper.convertDiseaseCodeToKorean(diseaseCode: "T00", code: result_T00[1].label), score : result_T00[1].score)
                                
                                Spacer().frame(height : 10)

                                InspectionResultRow(disease : InspectionHelper.convertDiseaseCodeToKorean(diseaseCode: "T00", code: result_T00[2].label), score : result_T00[2].score)
                            }.padding(10)
                        }
                        
                        Spacer().frame(height : 20)

                        Group{
                            HStack{
                                Text("뇌신경장애 (T01) 검사 결과")
                                    .fontWeight(.semibold)
                                    .foregroundColor(.txt_color)
                                
                                Spacer()
                                
                                Text(InspectionHelper.convertDiseaseCodeToKorean(diseaseCode: "T01", code: result_T01.first?.label ?? ""))
                                    .foregroundColor(.accent)
                                    .fontWeight(.semibold)
                            }
                            
                            Spacer().frame(height : 10)
                            
                            Divider()
                            
                            Spacer().frame(height : 10)

                            VStack{
                                InspectionResultRow(disease : InspectionHelper.convertDiseaseCodeToKorean(diseaseCode: "T01", code: result_T01[0].label), score : result_T01[0].score)
                                
                                Spacer().frame(height : 10)

                                InspectionResultRow(disease : InspectionHelper.convertDiseaseCodeToKorean(diseaseCode: "T01", code: result_T01[1].label), score : result_T01[1].score)
                            }.padding(10)
                        }
                        
                        Spacer().frame(height : 20)

                        Group{
                            HStack{
                                Text("언어청각장애 (T02) 검사 결과")
                                    .fontWeight(.semibold)
                                    .foregroundColor(.txt_color)
                                
                                Spacer()
                                
                                Text(InspectionHelper.convertDiseaseCodeToKorean(diseaseCode: "T02", code: result_T02.first?.label ?? ""))
                                    .foregroundColor(.accent)
                                    .fontWeight(.semibold)
                            }
                            
                            Spacer().frame(height : 10)
                            
                            Divider()
                            
                            Spacer().frame(height : 10)

                            VStack{
                                InspectionResultRow(disease : InspectionHelper.convertDiseaseCodeToKorean(diseaseCode: "T02", code: result_T02[0].label), score : result_T02[0].score)
                                
                                Spacer().frame(height : 10)

                                InspectionResultRow(disease : InspectionHelper.convertDiseaseCodeToKorean(diseaseCode: "T02", code: result_T02[1].label), score : result_T02[1].score)
                                
                                Spacer().frame(height : 10)

                                InspectionResultRow(disease : InspectionHelper.convertDiseaseCodeToKorean(diseaseCode: "T02", code: result_T02[2].label), score : result_T02[2].score)
                                
                                Spacer().frame(height : 10)

                                InspectionResultRow(disease : InspectionHelper.convertDiseaseCodeToKorean(diseaseCode: "T02", code: result_T02[3].label), score : result_T02[3].score)
                            }.padding(10)
                        }
                        
                        Spacer().frame(height : 20)

                        Group{
                            HStack{
                                Text("후두장애 (T03) 검사 결과")
                                    .fontWeight(.semibold)
                                    .foregroundColor(.txt_color)
                                
                                Spacer()
                                
                                Text(InspectionHelper.convertDiseaseCodeToKorean(diseaseCode: "T03", code: result_T03.first?.label ?? ""))
                                    .foregroundColor(.accent)
                                    .fontWeight(.semibold)
                            }
                            
                            Spacer().frame(height : 10)
                            
                            Divider()
                            
                            Spacer().frame(height : 10)

                            VStack{
                                InspectionResultRow(disease : InspectionHelper.convertDiseaseCodeToKorean(diseaseCode: "T03", code: result_T03[0].label), score : result_T03[0].score)
                                
                                Spacer().frame(height : 10)

                                InspectionResultRow(disease : InspectionHelper.convertDiseaseCodeToKorean(diseaseCode: "T03", code: result_T03[1].label), score : result_T03[1].score)
                                
                                Spacer().frame(height : 10)

                                InspectionResultRow(disease : InspectionHelper.convertDiseaseCodeToKorean(diseaseCode: "T03", code: result_T03[2].label), score : result_T03[2].score)
                            }.padding(10)
                        }
                        
                        Spacer().frame(height : 20)
                        
                        HStack{
                            Text("음성 데이터 렌더링 결과 (Audio Spectrogram)")
                                .fontWeight(.semibold)
                                .foregroundColor(.txt_color)
                            
                            Spacer()
                        }
                        
                        Spacer().frame(height : 10)
                        
                        Divider()
                        
                        Spacer().frame(height : 10)
                        
                        Image(uiImage: UIImage(cgImage: helper.spectrogram!))
                            .resizable()
                            .frame(width : 350, height : 350)
                            .aspectRatio(contentMode: .fit)
                        
                        Spacer().frame(height : 20)

                        Button(action: {
                            
                        }){
                            HStack{
                                Image(systemName : "square.and.arrow.up")
                                Text("PDF 내보내기")
                            }
                        }.buttonStyle(BorderedButtonStyle())
                        
                        Spacer().frame(height : 10)

                        Text("구음장애가 의심되는 경우 이 검사결과를 PDF로 내보내어 의료기관에 참고자료로 제출할 수 있습니다.")
                            .font(.caption)
                            .foregroundColor(.gray)
                            .multilineTextAlignment(.center)
                        
                        Spacer().frame(height : 20)

                        Image(systemName : "person.badge.shield.checkmark.fill")
                            .resizable()
                            .frame(width : 30, height : 30)
                            .foregroundColor(.accent)
                        
                        Text("Dysarthria Checker는 구음장애의 완전한 진단 및 치료를 보장하지 않으며, 환자는 Dysarthria Checker를 통해 치료상의 이익을 얻을 수 없습니다.\n구음장애가 의심되는 경우 전문가와 상담을 통해 의학적 조치를 받으십시오.")
                            .font(.caption)
                            .multilineTextAlignment(.center)
                            .foregroundColor(.gray)
                        
                        Spacer().frame(height : 20)

                        AboutDysarthriaView()
                        
                    }.navigationBarTitle("검사 결과")
                        .navigationBarTitleDisplayMode(.inline)
                        .padding(20)
                }
            }.navigationBarItems(trailing: Button("닫기"){
                self.presentationmode.wrappedValue.dismiss()
            })
        }
    }
}

#Preview {
    InspectionResultView(helper : InspectionHelper(), result_T00: [PredictResult(score: 1.0, label: "TEST_T00")], result_T01: [PredictResult(score: 1.0, label: "TEST_T01")], result_T02: [PredictResult(score: 1.0, label: "TEST_T02")], result_T03: [PredictResult(score: 1.0, label: "TEST_T03")])
}
