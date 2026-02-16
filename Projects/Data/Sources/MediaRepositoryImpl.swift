//
//  MediaRepositoryImpl.swift
//  QCells
//
//  Created by Sindhuja Gundla on 2/8/26.
//  Copyright © 2026 QCells. All rights reserved.
//

import Domain
import Foundation

public final class MediaRepositoryImpl: MediaRepository {
    private let api = ITunesAPIClient()

    public init() {}   

    public func search(
        term: String,
        category: MediaCategory,
        limit: Int?
    ) async throws -> [MediaItem] {

        let media: String
        let entity: String

        switch category {
        case .song:
            media = "music"
            entity = "song"
        case .podcast:
            media = "podcast"
            entity = "podcast"
        case .tvShow:
            media = "tvShow"
            entity = "tvEpisode"
        }

        return try await api.fetch(
            term: term,
            media: media,
            entity: entity,
            limit: limit
        )
        .map { $0.toDomain() }
    }
}
