//
//  MainTabView.swift
//  Newsletter
//
//  Created by Христиченко Александр on 2023-06-02.
//

import SwiftUI

struct MainTabView: View {
    var body: some View {
        TabView() {
            HomeNewsView()
                .tabItem {
                    Image("house")
                    Text("Home")
                }
            
            FavoriteNewsView()
                .tabItem {
                    Image("heart")
                    Text("Favorite")
                }
        }
    }
}

struct MainTabView_Previews: PreviewProvider {
    static let homeViewModel = NewsViewModel()
    static var previews: some View {
        MainTabView()
            .environmentObject(homeViewModel)
    }
}
