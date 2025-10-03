//
//  habitsApp.swift
//  habits
//
//  Created by Abeer Jeilani Osman  on 07/04/1447 AH.
//

import SwiftUI

@main
struct habitsApp: App {
    @StateObject private var userData = UserData()
       
    var body: some Scene {
        WindowGroup {
            SplashPage()
                .environmentObject(userData)

               
        }
    }
}
