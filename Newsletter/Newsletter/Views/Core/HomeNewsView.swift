//
//  HomeNewsView.swift
//  Newsletter
//
//  Created by Христиченко Александр on 2023-06-02.
//

import SwiftUI

struct HomeNewsView: View {
    //MARK: - PROPERTIES
    @EnvironmentObject private var homeVM: NewsViewModel
    
    //MARK: - BODY
    var body: some View {
        ZStack(alignment: .top) {
            background
            VStack {
                title
                articles
            }
        }
        .onAppear {
            homeVM.getAllArticles()
        }
    }
}

//MARK: - PREVIEW
struct HomeNewsView_Previews: PreviewProvider {
    static let homeViewModel = NewsViewModel()
    static var previews: some View {
        HomeNewsView()
            .environmentObject(homeViewModel)
    }
}

//MARK: - COMPONENTS
extension HomeNewsView {
    private var background: some View {
        Color.generalTheme.background.opacity(0.3).ignoresSafeArea()
    }
    
    private var title: some View {
        Text("News")
            .modifier(FontModifier(fontName: Constants.latoBold, fontSize: 25))
            .frame(maxWidth: .infinity, alignment: .center)
            .foregroundColor(Color.white)
            .padding(.vertical, 8)
            .background(Color.generalTheme.purple)
    }
    
    private var articles: some View {
        ScrollView {
            ForEach(homeVM.articles) { article in
                NavigationLink(destination: {
                    NewsDetailView(article: article)
                        .navigationBarBackButtonHidden(true)
                }, label: {
                    HomeNewsRow(article: article)
                })
            }
        }
        .offset(y: -8)
    }
}
