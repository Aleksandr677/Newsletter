//
//  Article.swift
//  Newsletter
//
//  Created by Христиченко Александр on 2023-05-30.
//

import UIKit

struct Article: Decodable, Hashable {
    let title: String?
    let description: String?
    let author: String?
    let publishedAt: String?
    let urlToImage: URL?
    let url: URL?
    let content: String?
    
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
    
    var authorName: String {
        if let author = author {
            return author
        } else {
            return "Unknown"
        }
    }
}
