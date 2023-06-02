//
//  HomeNewsRow.swift
//  Newsletter
//
//  Created by Христиченко Александр on 2023-06-02.
//

import SwiftUI

struct HomeNewsRow: View {
    //MARK: - PROPERTIES
    let article: Article
    @State private var hasImage: Bool = true
    
    //MARK: - BODY
    var body: some View {
        ZStack {
            background
            HStack(spacing: 10) {
                image
                texts
            } //HStack
        } //ZStack
        .frame(maxWidth: .infinity, alignment: .center)
        .frame(height: 130)
        .background(Color.white)
        .cornerRadius(20)
        .shadow(color: Color.generalTheme.purple.opacity(0.2), radius: 15, x: 0, y: 0)
        .padding(.horizontal)
        .padding(.vertical)
        .onAppear {
            DispatchQueue.main.asyncAfter(deadline: .now() + 3) {
                hasImage = false
            }
        }
    }
}

//MARK: - PREVIEW
struct HomeNewsRow_Previews: PreviewProvider {
    static var previews: some View {
        HomeNewsRow(article: Constants.article)
    }
}

//MARK: - COMPONENTS
extension HomeNewsRow {
    
    private var background: some View {
        Color.generalTheme.background.opacity(0.35)
    }
    
    private var image: some View {
        AsyncImage(url: article.urlToImage) { image in
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
    }
    
    private var texts: some View {
        VStack(alignment: .leading, spacing: 2) {
            (Text("Title:  ")
                .foregroundColor(.gray)
                .fontWeight(.regular)
            + Text(article.title ?? "Unknown"))
                .modifier(FontModifier(fontName: Constants.latoBold, fontSize: 15))
                .multilineTextAlignment(.leading)
                .lineLimit(nil)
                .foregroundColor(.black)
             
            (Text("Source:  ")
                .foregroundColor(.gray)
                .fontWeight(.regular)
            + Text("\(article.author ?? "Unknown")"))
                .modifier(FontModifier(fontName: Constants.latoBold, fontSize: 14))
                .multilineTextAlignment(.leading)
                .lineLimit(nil)
                .foregroundColor(.black)
            
            (Text("Time:  ")
                .foregroundColor(.gray)
                .fontWeight(.regular)
            + Text("\(article.date)"))
                .modifier(FontModifier(fontName: Constants.latoBold, fontSize: 12))
                .multilineTextAlignment(.leading)
                .lineLimit(nil)
                .foregroundColor(.black)
        }
        .frame(maxHeight: .infinity, alignment: .center)
    }
}
