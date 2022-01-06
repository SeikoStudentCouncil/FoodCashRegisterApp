//
//  Food_Cash_RegisterApp.swift
//  Food Cash Register
//
//  Created by Yoshihiro on 2021/07/29.
//
import SwiftUI

@main
struct SwiftUI_LefecycleApp: App {
    var body: some Scene {
        WindowGroup {
            ContentView()
                .environmentObject(Settings())
        }
    }
}
