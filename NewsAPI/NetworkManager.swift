//
//  NetworkManager.swift
//  NewsAPI
//
//  Created by Олег Рубан on 17.04.2022.
//

import Foundation


struct NetworkManager {
    static let shared = NetworkManager()
    
    let url = "https://newsapi.org/v2/top-headlines?country=us&category=business&apiKey=36d08a448fc447438e3d3a9c79405b32"
    let searchUrlString = "https://newsapi.org/v2/everything?sortedBy=popularity&apiKey=36d08a448fc447438e3d3a9c79405b32&q="
    
    public func fetchNews(completion: @escaping (Result<[Article], Error>) -> Void) {
        guard let url = URL(string: url) else { return }
        
        let task = URLSession.shared.dataTask(with: url) { (data, _, error) in
            if let error = error {
                completion(.failure(error))
            } else if let data = data {
                do {
                    let result = try JSONDecoder().decode(API.self, from: data)
                    //print(result.articles.count)
                    completion(.success(result.articles))
                }
                catch {
                    completion(.failure(error))
                }
            }
        }
        task.resume()
    }
    
    public func searchNews(with query: String, completion: @escaping (Result<[Article], Error>) -> Void) {
        guard !query.trimmingCharacters(in: .whitespaces).isEmpty else { return }
        let urlSearch = searchUrlString + query
        print(urlSearch)
        guard let url = URL(string: urlSearch) else { return }
        
        let task = URLSession.shared.dataTask(with: url) { (data, _, error) in
            if let error = error {
                completion(.failure(error))
            } else if let data = data {
                do {
                    let result = try JSONDecoder().decode(API.self, from: data)
                    //print(result.articles.count)
                    completion(.success(result.articles))
                }
                catch {
                    completion(.failure(error))
                }
            }
        }
        task.resume()
    }
}
