//
//  FavoriteNewsRow.swift
//  Newsletter
//
//  Created by Христиченко Александр on 2023-06-03.
//

import SwiftUI

struct FavoriteNewsRow: View {
    //MARK: - PROPERTIES
    @State private var hasImage: Bool = true
    let article: FavoriteNewsList
    
    //MARK: - BODY
    var body: some View {
        ZStack {
            background
            HStack(alignment: .top, spacing: 10) {
                image
                texts
            } //HStack
            .frame(maxWidth: .infinity, alignment: .leading)
        } //ZStack
        .frame(maxWidth: .infinity, alignment: .center)
        .frame(height: 130)
        .background(Color.white)
        .cornerRadius(20)
        .shadow(color: Color.generalTheme.purple.opacity(0.2), radius: 15, x: 0, y: 0)
        .onAppear {
            DispatchQueue.main.asyncAfter(deadline: .now() + 3) {
                hasImage = false
            }
        }
    }
}

//MARK: - PREVIEW
struct FavoriteNewsRow_Previews: PreviewProvider {
    static let homeViewModel = NewsViewModel()
    static var previews: some View {
        FavoriteNewsRow(article: FavoriteNewsList())
            .environmentObject(homeViewModel)
    }
}

//MARK: - COMPONENTS
extension FavoriteNewsRow {
    private var background: some View {
        Color.generalTheme.background.opacity(0.35)
    }
    
    private var image: some View {
        AsyncImage(url: URL(string: article.newsImage)) { image in
            image
                .resizable()
                .aspectRatio(1, contentMode: .fit)
                .frame(width: 100, height: 100)
        } placeholder: {
            if !hasImage {
                ZStack {
                    Color.clear.frame(width: 100, height: 100)
                    Image(systemName: "photo")
                        .resizable()
                        .scaledToFit()
                        .frame(width: 50, height: 50)
                        .foregroundColor(Color.generalTheme.purple)
                }
            } else {
                ProgressView()
                    .frame(width: 100, height: 100)
            }
        }
        .cornerRadius(5)
        .padding(.leading)
        .frame(maxHeight: .infinity, alignment: .center)
    }
    
    private var texts: some View {
        VStack(alignment: .leading, spacing: 2) {
            (Text("Title:  ")
                .foregroundColor(.gray)
                .fontWeight(.regular)
            + Text(article.newsTitle))
                .modifier(FontModifier(fontName: Constants.latoBold, fontSize: 15))
                .multilineTextAlignment(.leading)
                .lineLimit(nil)
                .foregroundColor(.black)
            (Text("Source:  ")
                .foregroundColor(.gray)
                .fontWeight(.regular)
            + Text("\(article.newsAuthor)"))
                .modifier(FontModifier(fontName: Constants.latoBold, fontSize: 14))
                .multilineTextAlignment(.leading)
                .lineLimit(nil)
                .foregroundColor(.black)
        }
        .padding(.vertical)
        .frame(maxHeight: .infinity, alignment: .leading)
    }
    
    private var deleteButton: some View {
        HStack {
            Divider()
            Button(action: {
                
            }, label: {
                Image(systemName: "trash")
                    .padding(8)
                    .background(Circle().stroke(lineWidth: 1.5))
                    .padding(.leading, 4)
                    .padding(.trailing, 12)
                    .foregroundColor(Color.generalTheme.purple)
            })
        }
        .frame(maxWidth: .infinity, alignment: .trailing)
    }
}
