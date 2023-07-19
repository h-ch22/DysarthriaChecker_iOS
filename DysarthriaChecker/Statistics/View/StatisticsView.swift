//
//  StatisticsView.swift
//  DysarthriaChecker
//
//  Created by 하창진 on 7/18/23.
//

import SwiftUI

struct StatisticsView: View {
    @State private var showProgress = true
    @State private var currentIndex = 0
    @State private var url: URL? = nil
    
    @StateObject var helper : UserManagement
    
    
    var body: some View {
        NavigationView{
            ZStack{
                Color.backgroundColor.edgesIgnoringSafeArea(.all)
                
                if showProgress{
                    VStack{
                        Spacer()
                        
                        ProgressView()
                        
                        Spacer()
                    }
                } else{
                    ScrollView{
                        VStack{
                            HStack{
                                Button(action: {
                                    if currentIndex < helper.inspectionResults.count - 1{
                                        currentIndex += 1
                                        
                                        helper.getSpectrograms(id: helper.inspectionResults[currentIndex].targetDate ?? ""){result in
                                            guard let result = result else{return}
                                            self.url = result
                                        }
                                    }
                                }){
                                    Image(systemName : "chevron.left.circle.fill")
                                        .foregroundColor(currentIndex == helper.inspectionResults.count - 1 ? .gray : .accent)
                                }
                                
                                Spacer()
                                
                                Text(helper.inspectionResults[currentIndex].targetDate ?? "")
                                    .foregroundStyle(Color.txt_color)
                                
                                Spacer()
                                
                                Button(action: {
                                    if currentIndex > 0{
                                        currentIndex -= 1
                                                                                
                                        helper.getSpectrograms(id: helper.inspectionResults[currentIndex].targetDate ?? ""){result in
                                            guard let result = result else{return}
                                            self.url = result
                                        }
                                    }
                                }){
                                    Image(systemName: "chevron.right.circle.fill")
                                        .foregroundColor(currentIndex == 0 ? .gray : .accent)
                                }
                            }
                            
                            Spacer().frame(height : 40)
                            
                            HStack{
                                Text("통합 (T00) 검사 결과")
                                    .fontWeight(.semibold)
                                    .foregroundColor(.txt_color)
                                
                                Spacer()
                                
                                Text(InspectionHelper.convertDiseaseCodeToKorean(diseaseCode: "T00", code: helper.inspectionResults[currentIndex].T00?.first?.label ?? ""))
                                    .foregroundColor(.accent)
                                    .fontWeight(.semibold)
                            }
                            
                            Spacer().frame(height : 10)
                            
                            Divider()
                            
                            Spacer().frame(height : 10)
                            
                            VStack{
                                InspectionResultRow(disease : InspectionHelper.convertDiseaseCodeToKorean(diseaseCode: "T00", code: helper.inspectionResults[currentIndex].T00?[0].label ?? ""), score : helper.inspectionResults[currentIndex].T00?[0].score ?? 0.0)
                                
                                Spacer().frame(height : 10)
                                
                                InspectionResultRow(disease : InspectionHelper.convertDiseaseCodeToKorean(diseaseCode: "T00", code: helper.inspectionResults[currentIndex].T00?[1].label ?? ""), score : helper.inspectionResults[currentIndex].T00?[1].score ?? 0.0)
                                
                                Spacer().frame(height : 10)
                                
                                InspectionResultRow(disease : InspectionHelper.convertDiseaseCodeToKorean(diseaseCode: "T00", code: helper.inspectionResults[currentIndex].T00?[2].label ?? ""), score : helper.inspectionResults[currentIndex].T00?[2].score ?? 0.0)
                            }.padding(10)
                        }
                        
                        Spacer().frame(height : 20)
                        
                        HStack{
                            Text("뇌신경장애 (T01) 검사 결과")
                                .fontWeight(.semibold)
                                .foregroundColor(.txt_color)
                            
                            Spacer()
                            
                            Text(InspectionHelper.convertDiseaseCodeToKorean(diseaseCode: "T01", code: helper.inspectionResults[currentIndex].T01?.first?.label ?? ""))
                                .foregroundColor(.accent)
                                .fontWeight(.semibold)
                        }
                        
                        Spacer().frame(height : 10)
                        
                        Divider()
                        
                        Spacer().frame(height : 10)
                        
                        VStack{
                            InspectionResultRow(disease : InspectionHelper.convertDiseaseCodeToKorean(diseaseCode: "T01", code: helper.inspectionResults[currentIndex].T01?[0].label ?? ""), score : helper.inspectionResults[currentIndex].T01?[0].score ?? 0.0)
                            
                            Spacer().frame(height : 10)
                            
                            InspectionResultRow(disease : InspectionHelper.convertDiseaseCodeToKorean(diseaseCode: "T01", code: helper.inspectionResults[currentIndex].T01?[1].label ?? ""), score : helper.inspectionResults[currentIndex].T01?[1].score ?? 0.0)
                        }.padding(10)
                        
                        Spacer().frame(height : 20)
                        
                        HStack{
                            Text("언어청각장애 (T02) 검사 결과")
                                .fontWeight(.semibold)
                                .foregroundColor(.txt_color)
                            
                            Spacer()
                            
                            Text(InspectionHelper.convertDiseaseCodeToKorean(diseaseCode: "T02", code: helper.inspectionResults[currentIndex].T02?.first?.label ?? ""))
                                .foregroundColor(.accent)
                                .fontWeight(.semibold)
                        }
                        
                        Spacer().frame(height : 10)
                        
                        Divider()
                        
                        Spacer().frame(height : 10)
                        
                        VStack{
                            InspectionResultRow(disease : InspectionHelper.convertDiseaseCodeToKorean(diseaseCode: "T02", code: helper.inspectionResults[currentIndex].T02?[0].label ?? ""), score : helper.inspectionResults[currentIndex].T02?[0].score ?? 0.0)
                            
                            Spacer().frame(height : 10)
                            
                            InspectionResultRow(disease : InspectionHelper.convertDiseaseCodeToKorean(diseaseCode: "T02", code: helper.inspectionResults[currentIndex].T02?[1].label ?? ""), score : helper.inspectionResults[currentIndex].T02?[1].score ?? 0.0)
                            
                            Spacer().frame(height : 10)
                            
                            InspectionResultRow(disease : InspectionHelper.convertDiseaseCodeToKorean(diseaseCode: "T02", code: helper.inspectionResults[currentIndex].T02?[2].label ?? ""), score : helper.inspectionResults[currentIndex].T02?[2].score ?? 0.0)
                            
                            Spacer().frame(height : 10)
                            
                            InspectionResultRow(disease : InspectionHelper.convertDiseaseCodeToKorean(diseaseCode: "T02", code: helper.inspectionResults[currentIndex].T02?[3].label ?? ""), score : helper.inspectionResults[currentIndex].T02?[3].score ?? 0.0)
                        }.padding(10)
                        
                        Spacer().frame(height : 20)
                        
                        HStack{
                            Text("후두장애 (T03) 검사 결과")
                                .fontWeight(.semibold)
                                .foregroundColor(.txt_color)
                            
                            Spacer()
                            
                            Text(InspectionHelper.convertDiseaseCodeToKorean(diseaseCode: "T03", code: helper.inspectionResults[currentIndex].T03?.first?.label ?? ""))
                                .foregroundColor(.accent)
                                .fontWeight(.semibold)
                        }
                        
                        Spacer().frame(height : 10)
                        
                        Divider()
                        
                        Spacer().frame(height : 10)
                        
                        VStack{
                            InspectionResultRow(disease : InspectionHelper.convertDiseaseCodeToKorean(diseaseCode: "T03", code: helper.inspectionResults[currentIndex].T03?[0].label ?? ""), score : helper.inspectionResults[currentIndex].T03?[0].score ?? 0.0)
                            
                            Spacer().frame(height : 10)
                            
                            InspectionResultRow(disease : InspectionHelper.convertDiseaseCodeToKorean(diseaseCode: "T03", code: helper.inspectionResults[currentIndex].T03?[1].label ?? ""), score : helper.inspectionResults[currentIndex].T03?[1].score ?? 0.0)
                            
                            Spacer().frame(height : 10)
                            
                            InspectionResultRow(disease : InspectionHelper.convertDiseaseCodeToKorean(diseaseCode: "T03", code: helper.inspectionResults[currentIndex].T03?[2].label ?? ""), score : helper.inspectionResults[currentIndex].T03?[2].score ?? 0.0)
                        }.padding(10)
                        
                        Spacer().frame(height : 20)
                        
                        if self.url != nil{
                            HStack{
                                Text("음성 데이터 렌더링 결과 (Audio Spectrogram)")
                                    .fontWeight(.semibold)
                                    .foregroundColor(.txt_color)
                                
                                Spacer()
                            }
                            
                            Spacer().frame(height : 10)
                            
                            Divider()
                            
                            Spacer().frame(height : 10)
                            
                            AsyncImage(url: url!){ image in
                                image
                                    .resizable()
                                    .frame(width : 350, height : 350)
                                    .aspectRatio(contentMode: .fit)
                            } placeholder: {
                                ProgressView()
                            }
                            
                            Spacer().frame(height : 20)
                        }

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
                        
                    }.padding(20)
                    
                    
                }
                
                
            }
            .navigationTitle(Text("검사 기록"))
            .onAppear{
                helper.getInspectionResults(){ result in
                    guard let result = result else{return}
                    
                    currentIndex = helper.inspectionResults.count - 1
                    
                    helper.getSpectrograms(id: helper.inspectionResults[currentIndex].targetDate ?? ""){result in
                        guard let result = result else{return}
                        self.url = result
                    }
                    
                    showProgress = false
                }
            }
        }
    }
}

#Preview {
    StatisticsView(helper: UserManagement())
}
