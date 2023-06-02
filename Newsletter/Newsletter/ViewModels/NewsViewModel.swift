//
//  NewsViewModel.swift
//  Newsletter
//
//  Created by Христиченко Александр on 2023-05-31.
//

import UIKit
import Combine

final class NewsViewModel: ObservableObject {
    private let newsService = NewsService()
    @Published var articles: [Article] = []
    private var cancellables = Set<AnyCancellable>()
    
    func getAllArticles() {
        newsService.$allnews
            .sink(receiveCompletion: { completion in
                
            }, receiveValue: { [weak self] articles in
                self?.articles = articles
            })
            .store(in: &cancellables)
    }
}
