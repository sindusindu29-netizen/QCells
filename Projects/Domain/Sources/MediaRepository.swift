//
//  MediaRepository.swift
//  QCells
//
//  Created by Sindhuja Gundla on 2/8/26.
//  Copyright © 2026 QCells. All rights reserved.
//

public protocol MediaRepository {
    func search(term: String, category: MediaCategory, limit: Int?) async throws -> [MediaItem]
}
