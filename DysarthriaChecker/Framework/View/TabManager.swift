//
//  TabManager.swift
//  DysarthriaChecker
//
//  Created by Changjin Ha on 2023/05/02.
//

import SwiftUI

struct TabManager: View {
    @State var selectedIndex = 0
    @State private var showModal = false
    @StateObject var userManagement : UserManagement

    let icon = ["house.fill", "map.fill", "waveform", "rectangle.3.offgrid.bubble.left.fill", "ellipsis.circle.fill"]
    
    var body: some View {
        NavigationView{
            VStack{
                ZStack{
                    switch selectedIndex{
                    case 0:
                        HomeView(helper : userManagement)
                            .navigationBarHidden(true)
                        
                    case 1:
                        EmptyView()
                            .navigationBarHidden(true)
                    case 3:
                        TrainView()

                        
                    case 4:
                        MoreView(helper : userManagement)
                            .navigationBarHidden(true)
                    default:
                        HomeView(helper : userManagement)
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
        TabManager(userManagement: UserManagement())
    }
}
