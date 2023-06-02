//
//  Article.swift
//  Newsletter
//
//  Created by Христиченко Александр on 2023-05-30.
//

import UIKit

struct Article: Decodable, Identifiable {
    let title: String?
    let description: String?
    let author: String?
    let publishedAt: String?
    let urlToImage: URL?
    let url: URL?
    let content: String?
    
    var id: String {
        return UUID().uuidString
    }
    
    var date: String {
        let dateFormatter = DateFormatter()
        dateFormatter.dateFormat = "yyyy-MM-dd HH:mm:ssz"
        dateFormatter.timeZone = TimeZone(abbreviation: "UTC")
        
        if let date = publishedAt {
            let dt = dateFormatter.date(from: date)
            dateFormatter.timeZone = NSTimeZone.local
            dateFormatter.dateFormat = "dd-MM-yyyy"
            return dateFormatter.string(from: dt ?? Date())
        } else {
            return "Unknown"
        }
    }
    
    var urlNews: URL {
        if let url = url {
            return url
        } else {
            return URL(string:"https://www.google.com/")!
        }
    }
}
