//
//  NewsService.swift
//  NewsFlow
//
//  Created by Христиченко Александр on 2023-06-01.
//

import Foundation
import Combine

class NewsService {
    @Published var allnews: [Article] = []
    var subscription: AnyCancellable?
    
    init() {
        getNews()
    }
    
    private func getNews() {
        guard let url = URL(string: "https://newsapi.org/v2/top-headlines?country=us&apiKey=ce403f32d1d948eb9f1ddd835f95418b") else { return }
        
        subscription = NetworkingManager.download(url: url)
            .decode(type: News.self, decoder: JSONDecoder())
            .receive(on: DispatchQueue.main)
            .sink(receiveCompletion: NetworkingManager.handleCompletion,
                  receiveValue: { [weak self] (returnedItems) in
                self?.allnews = returnedItems.articles
                self?.subscription?.cancel()
            })
    }
}
