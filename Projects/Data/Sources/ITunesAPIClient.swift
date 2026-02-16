//
//  ITunesAPIClient.swift
//  QCells
//
//  Created by Sindhuja Gundla on 2/8/26.
//  Copyright © 2026 QCells. All rights reserved.
//

import Foundation

final class ITunesAPIClient {
    func fetch(term: String, media: String, entity: String, limit: Int?) async throws -> [MediaItemDTO] {
        var components = URLComponents(string: "https://itunes.apple.com/search")!
        components.queryItems = [
            URLQueryItem(name: "term", value: term),
            URLQueryItem(name: "media", value: media),
            URLQueryItem(name: "entity", value: entity)
        ]
        if let limit {
            components.queryItems?.append(URLQueryItem(name: "limit", value: "\(limit)"))
        }
        
        
        let (data, _) = try await URLSession.shared.data(from: components.url!)
        let decoded = try JSONDecoder().decode(SearchResponse.self, from: data)
        return decoded.results
    }
}


struct SearchResponse: Decodable {
    let results: [MediaItemDTO]
}
