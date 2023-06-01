//
//  InfoView.swift
//  DysarthriaChecker
//
//  Created by Changjin Ha on 2023/05/03.
//

import SwiftUI

struct InfoView: View {
    let helper = VersionManagement()
    @State private var latest = ""
    
    var body: some View {
        ZStack{
            Color.backgroundColor.edgesIgnoringSafeArea(.all)
            
            VStack{
                Group{
                    HStack{
                        Image("ic_appstore_transparent")
                            .resizable()
                            .frame(width : 80, height : 80)
                            .padding(10)
                            .background(RoundedRectangle(cornerRadius: 15).foregroundColor(.btn_color).shadow(radius: 5))
                        
                        VStack(alignment : .leading){
                            TextLogoView()
                            Text("\(helper.getVersion()) (\(helper.getBuild()))")
                            
                            if helper.getVersion().contains("-b"){
                                Text("사전 출시 소프트웨어를 사용하고 있습니다.")
                                    .font(.caption)
                                    .foregroundColor(.gray)
                            }
                            
                            Spacer().frame(height : 10)
                            
                            if latest == "" || latest == nil{
                                HStack{
                                    Image(systemName : "xmark")
                                        .foregroundColor(.red)
                                    
                                    Text("버전 정보를 불러올 수 없습니다.")
                                        .font(.caption)
                                        .foregroundColor(.red)
                                }
                            } else if latest == helper.getVersion(){
                                HStack{
                                    Image(systemName : "checkmark")
                                        .foregroundColor(.green)
                                    
                                    Text("최신 버전입니다.")
                                        .font(.caption)
                                        .foregroundColor(.green)
                                }
                            } else{
                                HStack{
                                    Image(systemName : "exclamationmark.circle.fill")
                                        .foregroundColor(.orange)
                                    
                                    Text("업데이트가 필요합니다. (최신버전 : \(latest))")
                                        .font(.caption)
                                        .foregroundColor(.orange)
                                }
                            }
                        }
                    }.padding(10)
                    .background(RoundedRectangle(cornerRadius: 15).foregroundColor(.btn_color).opacity(0.6))
                }
                
                Group{
                    Spacer().frame(height : 40)

                    NavigationLink(destination : EmptyView()){
                        HStack{
                            Image(systemName: "doc.text.fill")
                                .resizable()
                                .frame(width : 20, height : 25)
                                .foregroundColor(.accent)
                            
                            VStack(alignment : .leading){
                                Text("최종 사용권 계약서 읽기")
                                    .foregroundColor(.txt_color)
                            }
                            
                            Spacer()
                        }.padding(20).background(RoundedRectangle(cornerRadius: 15).foregroundColor(.btn_color).shadow(radius: 5))
                    }
                    
                    Spacer().frame(height : 20)

                    NavigationLink(destination : EmptyView()){
                        HStack{
                            Image(systemName: "lock.doc.fill")
                                .resizable()
                                .frame(width : 20, height : 25)
                                .foregroundColor(.accent)
                            
                            VStack(alignment : .leading){
                                Text("개인정보 수집 및 처리방침 읽기")
                                    .foregroundColor(.txt_color)
                            }
                            
                            Spacer()
                        }.padding(20).background(RoundedRectangle(cornerRadius: 15).foregroundColor(.btn_color).shadow(radius: 5))
                    }
                    
                    Spacer().frame(height : 20)

                    NavigationLink(destination : EmptyView()){
                        HStack{
                            Image(systemName: "heart.fill")
                                .resizable()
                                .frame(width : 25, height : 25)
                                .foregroundColor(.accent)
                            
                            VStack(alignment : .leading){
                                Text("민감정보 수집 및 처리방침 읽기")
                                    .foregroundColor(.txt_color)
                            }
                            
                            Spacer()
                        }.padding(20).background(RoundedRectangle(cornerRadius: 15).foregroundColor(.btn_color).shadow(radius: 5))
                    }
                    
                    Spacer().frame(height : 20)

                    NavigationLink(destination : EmptyView()){
                        HStack{
                            Image(systemName: "figure.and.child.holdinghands")
                                .resizable()
                                .frame(width : 25, height : 25)
                                .foregroundColor(.accent)
                            
                            VStack(alignment : .leading){
                                Text("인간대상연구에 대한 내용 읽기")
                                    .foregroundColor(.txt_color)
                            }
                            
                            Spacer()
                        }.padding(20).background(RoundedRectangle(cornerRadius: 15).foregroundColor(.btn_color).shadow(radius: 5))
                    }
                    
                    Spacer().frame(height : 30)
                    
                    Text("© 2023 Ha Changjin,\nAll Rights Reserved.")
                        .font(.caption)
                        .multilineTextAlignment(.center)
                        .foregroundColor(.gray)
                }
            }.padding(20).onAppear{
                helper.getLatest(){ latest in
                    guard let latest = latest else{return}
                    if latest != nil{
                        self.latest = latest
                    }
                }
            }
        }
    }
}

struct InfoView_Previews: PreviewProvider {
    static var previews: some View {
        InfoView()
    }
}
