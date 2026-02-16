//
//  MediaItemDTO.swift
//  QCells
//
//  Created by Sindhuja Gundla on 2/8/26.
//  Copyright © 2026 QCells. All rights reserved.
//

import Foundation
import Domain

struct MediaItemDTO: Decodable {
    let trackId: Int64?
    let collectionId: Int64?

    let trackName: String?
    let collectionName: String?
    let artistName: String?

    let artworkUrl100: String?

    func toDomain() -> MediaItem {
        let stableId = trackId ?? collectionId ?? Int64(abs((trackName ?? collectionName ?? "unknown").hashValue))

        return MediaItem(
            id: stableId,
            title: trackName ?? collectionName ?? "Unknown",
            subtitle: artistName ?? collectionName ?? "",
            artworkURL: URL(string: artworkUrl100 ?? "")
        )
    }
}

