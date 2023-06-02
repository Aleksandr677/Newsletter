//
//  NewsViewModel.swift
//  Newsletter
//
//  Created by Христиченко Александр on 2023-05-31.
//

import UIKit
import Combine

class NewsViewModel {
    @Published var newsImage: UIImage = UIImage()
    @Published var favoriteNews: [Favorites] = []
    
    private let newsService = NewsService()
    @Published var articles: [Article] = []
    private var cancellables = Set<AnyCancellable>()
    
    func getAllArticles(tableView: UITableView) {
        newsService.$allnews
            .sink(receiveCompletion: { completion in
                
            }, receiveValue: { [weak self] articles in
                self?.articles = articles
                tableView.reloadData()
            })
            .store(in: &cancellables)
    }
    
    func downloadImage(url: URL?) {
        guard let url = url else {
            self.newsImage = UIImage(systemName: "square.slash")!
            return
        }
        URLSession.shared.dataTaskPublisher(for: url)
            .subscribe(on: DispatchQueue.global(qos: .default))
            .tryMap({ try NetworkingManager.handleURLResponse(output: $0, url: url) })
            .retry(3)
            .eraseToAnyPublisher()
            .sink(receiveCompletion: NetworkingManager.handleCompletion,
                  receiveValue: { [weak self] (data) in
                if let image = UIImage(data: data) {
                    self?.newsImage = image
                }
            })
            .store(in: &cancellables)
    }
    
    
    func addFavorite(favorite: Favorites) {
        self.favoriteNews.append(favorite)
    }
}
