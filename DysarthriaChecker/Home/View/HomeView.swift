//
//  HomeView.swift
//  DysarthriaChecker
//
//  Created by Changjin Ha on 2023/05/03.
//

import SwiftUI

struct HomeView: View {
    @StateObject var helper : UserManagement
    @State private var showProgress = false
    @State private var showStatistics = false
    @State private var selectedType : ResultTypeModel? = nil
    
    let parent: TabManager
    
    var body: some View {
        ZStack{
            Color.backgroundColor.edgesIgnoringSafeArea(.all)
            
            VStack{
                HStack{
                    Text("안녕하세요,\n\(helper.userInfo?.name ?? "알 수 없는 사용자")님😆")
                        .foregroundColor(.txt_color)
                        .fontWeight(.semibold)
                    
                    Spacer()
                }
                
                if showProgress{
                    Spacer()
                    
                    ProgressView()
                } else{
                    if helper.latestInspectionResult == nil{
                        Spacer()
                        
                        Text("최근 검사 기록이 없습니다.")
                            .foregroundColor(.gray)
                        
                        Spacer().frame(height : 20)
                        
                        Button(action: {
                            parent.showInspectionSheet()
                        }){
                            Text("검사하기")
                        }
                        
                    } else{
                        Spacer()
                        
                        HStack{
                            Text("최근 검사 기록")
                                .fontWeight(.semibold)
                                .foregroundColor(.txt_color)
                            
                            Spacer()
                            
                            Button(action: {
                                showProgress = true

                                helper.getLatestInspectionResults(){ result in
                                    guard let result = result else{return}
                                    showProgress = false
                                }
                            }){
                                HStack{
                                    Image(systemName : "arrow.clockwise.circle.fill")
                                        .font(.caption)
                                        .foregroundColor(.gray)
                                    
                                    Text("기준일 : \(helper.latestInspectionResult?.targetDate ?? "")")
                                        .font(.caption)
                                        .foregroundColor(.gray)
                                }
                            }
                        }
                        
                        Spacer().frame(height : 20)
                        
                        
                        HStack{
                            Button(action: {
                                selectedType = .T00
                                showStatistics = true
                            }){
                                HomeListModel(disease: "통합 (T00)", result: InspectionHelper.convertDiseaseCodeToKorean(diseaseCode: "T00", code: helper.latestInspectionResult?.T00?.first?.label ?? ""), point : helper.latestInspectionResult?.T00?.first?.score ?? 0.0)
                            }
                            
                            Spacer()
                            
                            Button(action: {
                                selectedType = .T01
                                showStatistics = true
                            }){
                                HomeListModel(disease: "뇌신경장애 (T01)", result: InspectionHelper.convertDiseaseCodeToKorean(diseaseCode: "T01", code: helper.latestInspectionResult?.T01?.first?.label ?? ""), point : helper.latestInspectionResult?.T01?.first?.score ?? 0.0)
                            }
                        }
                        
                        Spacer().frame(height : 20)
                        
                        HStack{
                            Button(action: {
                                selectedType = .T02
                                showStatistics = true
                            }){
                                HomeListModel(disease: "언어청각장애 (T02)", result: InspectionHelper.convertDiseaseCodeToKorean(diseaseCode: "T02", code: helper.latestInspectionResult?.T02?.first?.label ?? ""), point : helper.latestInspectionResult?.T02?.first?.score ?? 0.0)
                            }
                            
                            Spacer()
                            
                            Button(action: {
                                selectedType = .T03
                                showStatistics = true
                            }){
                                HomeListModel(disease: "후두장애 (T03)", result: InspectionHelper.convertDiseaseCodeToKorean(diseaseCode: "T03", code: helper.latestInspectionResult?.T03?.first?.label ?? ""), point : helper.latestInspectionResult?.T03?.first?.score ?? 0.0)
                            }
                        }
                                    
                        Spacer().frame(height : 40)

                        Button(action: {
                            parent.changeView(index: 1)
                        }){
                            HStack{
                                Image(systemName : "chart.xyaxis.line")
                                    .foregroundColor(.txt_color)
                                    
                                Text("검사 기록에서 전체 검사 결과 확인하기")
                                    .foregroundColor(.txt_color)

                            }.padding(20).background(RoundedRectangle(cornerRadius: 15).foregroundColor(.btn_color).shadow(radius: 2, x:0, y:2))
                        }
                    }
                }
                
                Spacer()
                
                AboutDysarthriaView()
                
                
            }.padding(20)
        }.animation(.easeInOut, value: 1.0)
            .onAppear{
                showProgress = true
                
                helper.getLatestInspectionResults(){result in
                    guard let result = result else{return}
                    
                    showProgress = false
                }
            }
            .sheet(isPresented: $showStatistics, content: {
                PartStatisticsView(type: selectedType ?? .T00, helper: helper)
            })
    }
}

struct HomeView_Previews: PreviewProvider {
    static var previews: some View {
        HomeView(helper: UserManagement(), parent: TabManager(userManagement: UserManagement()))
    }
}
