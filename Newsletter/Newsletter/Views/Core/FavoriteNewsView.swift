//
//  FavoriteNewsView.swift
//  Newsletter
//
//  Created by Христиченко Александр on 2023-06-02.
//

import SwiftUI

struct FavoriteNewsView: View {
    //MARK: - PROPERTIES
    @EnvironmentObject private var homeVM: NewsViewModel
    
    //MARK: - BODY
    var body: some View {
        ZStack(alignment: .top) {
            background
            VStack {
                title
                favoriteNews
            }
        }
    }
}

//MARK: - PREVIEW
struct FavoriteNewsView_Previews: PreviewProvider {
    static let homeViewModel = NewsViewModel()
    static var previews: some View {
        FavoriteNewsView()
            .environmentObject(homeViewModel)
    }
}

//MARK: - COMPONENTS
extension FavoriteNewsView {
    private var background: some View {
        Color.generalTheme.background.opacity(0.3).ignoresSafeArea()
    }
    
    private var title: some View {
        Text("Favorites")
            .modifier(FontModifier(fontName: Constants.latoBold, fontSize: 25))
            .frame(maxWidth: .infinity, alignment: .center)
            .foregroundColor(Color.white)
            .padding(.vertical, 8)
            .background(Color.generalTheme.purple)
    }
    
    private var favoriteNews: some View {
        List {
            ForEach(homeVM.favoriteNewsList.freeze(), id: \.id) { article in
                FavoriteNewsRow(article: article)
            }
            .onDelete { indexSet in
                homeVM.removeNewsFromFavorite(indexSet: indexSet)
            }
        }
        .offset(y: -8)
    }
}
