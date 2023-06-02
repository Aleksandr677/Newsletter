//
//  NewsletterApp.swift
//  Newsletter
//
//  Created by Христиченко Александр on 2023-06-02.
//

import SwiftUI

@main
struct NewsletterApp: App {
    @StateObject private var homeVM = NewsViewModel()
    
    init() {
        UITabBar.appearance().backgroundColor = UIColor(Color.generalTheme.purple)
    }
    
    var body: some Scene {
        WindowGroup {
            NavigationView {
                MainTabView()
            }
            .environmentObject(homeVM)
        }
    }
}
