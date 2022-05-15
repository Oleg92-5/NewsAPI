//
//  ViewModel.swift
//  NewsAPI
//
//  Created by Олег Рубан on 17.04.2022.
//

import Foundation

class ViewModel {
    let title: String
    let subtitle: String
    let imageURL: URL?
    var data: Data? = nil
    
    init(title: String, subtitle: String, imageURL: URL?) {
        self.title = title
        self.subtitle = subtitle
        self.imageURL = imageURL
    }
}

// MARK: - Welcome
struct API: Codable {
    let articles: [Article]
}

// MARK: - Article
struct Article: Codable {
    let source: Source
    let title: String
    let description: String?
    let url: String?
    let urlToImage: String?
    let publishedAt: String
}

// MARK: - Source
struct Source: Codable {
    let name: String
}
