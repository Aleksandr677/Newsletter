//
//  NewsViewModel.swift
//  Newsletter
//
//  Created by Христиченко Александр on 2023-05-31.
//

import SwiftUI
import Combine
import RealmSwift

final class NewsViewModel: ObservableObject {
    
    //Newtwork
    private let newsService = NewsService()
    @Published var articles: [Article] = []
    private var cancellables = Set<AnyCancellable>()
    
    //Save data
    @ObservedResults(FavoriteNewsList.self) var favoriteNewsList
    
    func getAllArticles() {
        newsService.$allnews
            .sink(receiveCompletion: { completion in
                switch completion {
                case .finished:
                    print("finished") //only for development
                case .failure(let error):
                    print(error.localizedDescription) //only for development
                }
            }, receiveValue: { [weak self] articles in
                guard let self = self else { return }
                self.articles = articles
            })
            .store(in: &cancellables)
    }
    
    func saveNewsToFavorite(article: Article) {
        let news = FavoriteNewsList()
        news.newsAuthor = article.author ?? "Unknown"
        news.newsTitle = article.title ?? "Unknown"
        news.newsDescription = article.description ?? "Unknown"
        news.newsImage = article.urlToImage?.description ?? "Unknown"
        news.newsContent = article.content ?? "Unknown"
        news.newsLink = article.urlNews.description
        $favoriteNewsList.append(news)
    }
    
    func removeNewsFromFavorite(indexSet: IndexSet) {
        $favoriteNewsList.remove(atOffsets: indexSet)
    }
}
