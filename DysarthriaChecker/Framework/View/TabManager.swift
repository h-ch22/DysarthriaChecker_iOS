//
//  TabManager.swift
//  DysarthriaChecker
//
//  Created by Changjin Ha on 2023/05/02.
//

import SwiftUI

struct TabManager: View {
    @State private var selectedIndex = 0
    @State private var showModal = false
    @StateObject private var userManagement = UserManagement()

    let icon = ["house.fill", "chart.xyaxis.line", "waveform", "rectangle.3.offgrid.bubble.left.fill", "ellipsis.circle.fill"]
    
    func changeView(index: Int){
        self.selectedIndex = index
    }
    
    func showInspectionSheet(){
        self.showModal = true
    }
    
    var body: some View {
        NavigationView{
            VStack{
                ZStack{
                    switch selectedIndex{
                    case 0:
                        HomeView(parent: self)
                            .navigationBarHidden(true)
                        
                    case 1:
                        StatisticsView()
                            .navigationBarHidden(true)
                    case 3:
                        TrainView()

                        
                    case 4:
                        MoreView()
                            .navigationBarHidden(true)
                    default:
                        HomeView(parent: self)
                            .navigationBarHidden(true)

                    }
                }
                
                Spacer()
                
                Divider()
                
                HStack{
                    ForEach(0..<5, id:\.self){number in
                        Spacer()
                        
                        Button(action: {
                            if number == 2{
                                self.showModal = true
                            }
                            
                            else{
                                selectedIndex = number
                            }
                        }){
                            if number == 2{
                                Image(systemName: icon[number])
                                    .font(.system(
                                        size: 25,
                                        weight: .regular,
                                        design: .default
                                    ))
                                    .foregroundColor(.white)
                                    .frame(width : 60, height : 60)
                                    .background(Color.accent)
                                    .cornerRadius(30)
                                    .shadow(radius: 3)
                            }
                            
                            else{
                                Image(systemName: icon[number])
                                    .font(.system(
                                        size: 25,
                                        weight: .regular,
                                        design: .default
                                    ))
                                    .foregroundColor(selectedIndex == number ? .accent : .gray)
                            }
                            
                        }
                        
                        Spacer()
                    }
                }
            }
            
            .sheet(isPresented: $showModal, content: {
                InspectionMainView()

            })
            
            .onAppear(perform: {

            })
            
            .background(Color.backgroundColor.edgesIgnoringSafeArea(.all))
            
            .accentColor(.accent)
        }
        .navigationBarHidden(true)
    }
}

struct TabManager_Previews: PreviewProvider {
    static var previews: some View {
        TabManager()
    }
}
