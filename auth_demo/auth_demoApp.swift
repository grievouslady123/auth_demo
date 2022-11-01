//
//  auth_demoApp.swift
//  auth_demo
//
//  Created by 暨大附中１ on 2022/11/1.
//

import SwiftUI
import Firebase

@main
struct auth_demoApp: App {
@StateObject var studentManger = StudentManager()
    init(){
        FirebaseApp.configure()
    }
    var body: some Scene {
        WindowGroup {
            ContentView().environmentObject(studentManger)
        }
    }
}
