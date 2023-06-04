//
//  FavoriteNewsList.swift
//  Newsletter
//
//  Created by Христиченко Александр on 2023-06-03.
//

import SwiftUI
import RealmSwift

class FavoriteNewsList: Object, Identifiable {
    @Persisted(primaryKey: true) var id: ObjectId
    @Persisted var newsTitle: String
    @Persisted var newsImage: String
    @Persisted var newsAuthor: String
    @Persisted var newsDescription: String
    @Persisted var newsContent: String
    @Persisted var newsLink: String
    
    override class func primaryKey() -> String? {
        "id"
    }
}
