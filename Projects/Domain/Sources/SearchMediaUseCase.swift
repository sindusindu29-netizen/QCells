//
//  SearchMediaUseCase.swift
//  QCells
//
//  Created by Sindhuja Gundla on 2/8/26.
//  Copyright © 2026 QCells. All rights reserved.
//

public final class SearchMediaUseCase {
    private let repository: MediaRepository
    
    
    public init(repository: MediaRepository) {
        self.repository = repository
    }
    
    public func execute(term: String, category: MediaCategory, limit: Int?) async throws -> [MediaItem] {
        try await repository.search(term: term, category: category, limit: limit)
        
    }
}
