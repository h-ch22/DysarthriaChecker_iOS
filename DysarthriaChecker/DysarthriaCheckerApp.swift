//
//  DysarthriaCheckerApp.swift
//  DysarthriaChecker
//
//  Created by Changjin Ha on 2023/04/22.
//

import SwiftUI
import FirebaseCore

class AppDelegate : NSObject, UIApplicationDelegate{
    func application(_ application: UIApplication, didFinishLaunchingWithOptions launchOptions: [UIApplication.LaunchOptionsKey : Any]? = nil) -> Bool {
        FirebaseApp.configure()
        return true
    }
}

@main
struct DysarthriaCheckerApp: App {
    @UIApplicationDelegateAdaptor(AppDelegate.self) var delegate
    
    var body: some Scene {
        WindowGroup {
            SplashView()
        }
    }
}

extension Color{
    static let backgroundColor = Color("background")
    static let accent = Color("AccentColor")
    static let btn_color = Color("btnColor")
    static let txt_color = Color("txtColor")
    static let btn_dark = Color("btn_dark")
    static let txt_dark = Color("txt_dark")
    static let tutorial_color_1 = Color("tutorialColor_1")
    static let tutorial_color_2 = Color("tutorialColor_2")
    static let tutorial_color_3 = Color("tutorialColor_3")
    static let audioSpectrum_gradient_start = Color("audioSpectrum_gradient_start")
    static let audioSpectrum_gradient_end = Color("audioSpectrum_gradient_end")
}

extension View {
    @ViewBuilder func isHidden(_ hidden: Bool, remove: Bool = false) -> some View {
        if hidden {
            if !remove {
                self.hidden()
            }
        } else {
            self
        }
    }
}
