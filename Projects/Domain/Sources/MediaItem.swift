//
//  MediaItem.swift
//  QCells
//
//  Created by Sindhuja Gundla on 2/8/26.
//  Copyright © 2026 QCells. All rights reserved.
//

import Foundation

public enum MediaCategory: String, CaseIterable {
    case song = "Songs"
    case podcast = "Podcasts"
    case tvShow = "TV Shows"
    
}

public struct MediaItem: Identifiable, Hashable {
    public let id: Int64
    public let title: String
    public let subtitle: String
    public let artworkURL: URL?

    public init(id: Int64, title: String, subtitle: String, artworkURL: URL?) {
        self.id = id
        self.title = title
        self.subtitle = subtitle
        self.artworkURL = artworkURL
    }
}

