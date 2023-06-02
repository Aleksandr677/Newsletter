//
//  NewsDetailView.swift
//  Newsletter
//
//  Created by Христиченко Александр on 2023-06-02.
//

import SwiftUI

struct NewsDetailView: View {
    //MARK: - PROPERTIES
    let article: Article
    @State private var hasImage: Bool = true
    @Environment(\.dismiss) private var dismiss
    
    //MARK: - BODY
    var body: some View {
        ZStack {
            background
            VStack {
                title
                ScrollView {
                    image
                    author
                    description
                    content
                    link
                }
                .offset(y: -8)
            }
        }
        .overlay(alignment: .topLeading, content: {
            Button(action: {
                dismiss.callAsFunction()
            }, label: {
                Image(systemName: "chevron.left")
                    .padding(.leading)
                    .padding(.top)
            })
        })
        .onAppear {
            DispatchQueue.main.asyncAfter(deadline: .now() + 3) {
                hasImage = false
            }
        }
    }
}

//MARK: - PREVIEW
struct NewsDetailView_Previews: PreviewProvider {
    static var previews: some View {
        NewsDetailView(article: Constants.article)
    }
}

//MARK: - COMPONENTS
extension NewsDetailView {
    private var background: some View {
        Color.generalTheme.background.opacity(0.3).ignoresSafeArea()
    }
    
    private var title: some View {
        Text("Details")
            .modifier(FontModifier(fontName: Constants.latoBold, fontSize: 25))
            .frame(maxWidth: .infinity, alignment: .center)
            .padding(.vertical, 8)
            .foregroundColor(Color.white)
            .background(Color.generalTheme.purple)
    }
    
    private var image: some View {
        AsyncImage(url: article.urlToImage) { image in
            image
                .resizable()
                .scaledToFill()
                .frame(minHeight: 250)
                .frame(maxWidth: .infinity, alignment: .center)
        } placeholder: {
            if !hasImage {
                ZStack {
                    Color.clear
                        .frame(minHeight: 250)
                        .frame(maxWidth: .infinity, alignment: .center)
                    Image(systemName: "photo")
                        .resizable()
                        .scaledToFit()
                        .frame(width: 50, height: 50)
                        .foregroundColor(Color.generalTheme.purple)
                }
            } else {
                ProgressView()
                    .frame(minHeight: 250)
                    .frame(maxWidth: .infinity, alignment: .center)
            }
        }
    }
    
    private var author: some View {
        (Text("Author:  ")
            .foregroundColor(.gray)
            .fontWeight(.regular)
        + Text(article.author ?? "Unknown"))
            .modifier(FontModifier(fontName: Constants.latoBold, fontSize: 16))
            .multilineTextAlignment(.leading)
            .lineLimit(nil)
            .frame(maxWidth: .infinity, alignment: .leading)
            .padding(.top)
            .padding(.horizontal)
    }
    
    private var description: some View {
        (Text("Description:  ")
            .foregroundColor(.gray)
            .fontWeight(.regular)
        + Text(article.description ?? "Unknown"))
            .modifier(FontModifier(fontName: Constants.latoBold, fontSize: 15))
            .multilineTextAlignment(.leading)
            .lineLimit(nil)
            .frame(maxWidth: .infinity, alignment: .leading)
            .padding(.vertical)
            .padding(.horizontal)
    }
    
    private var content: some View {
        (Text("Content:  ")
            .foregroundColor(.gray)
            .fontWeight(.regular)
        + Text(article.content ?? "Unknown"))
            .modifier(FontModifier(fontName: Constants.latoRegular, fontSize: 15))
            .multilineTextAlignment(.leading)
            .lineLimit(nil)
            .frame(maxWidth: .infinity, alignment: .leading)
            .padding(.horizontal)
    }
    
    private var link: some View {
        HStack {
            Group {
                Image(systemName: "arrow.up.right.square")
                Link("Want to see more? Go to the source.", destination: article.urlNews)
            }
            .foregroundColor(Color.white)
        }
        .padding(8)
        .background(Color.generalTheme.purple)
        .cornerRadius(10)
        .frame(maxWidth: .infinity, alignment: .center)
        .padding(.vertical)
    }
}
