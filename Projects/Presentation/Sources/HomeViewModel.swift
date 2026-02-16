//
//  HomeViewModel.swift
//  QCells
//
//  Created by Sindhuja Gundla on 2/8/26.
//  Copyright © 2026 QCells. All rights reserved.
//

import SwiftUI
import Domain
import Data

@MainActor
public final class HomeViewModel: ObservableObject {
    @Published public var results: [MediaCategory: [MediaItem]] = [:]
    @Published public var showNoResults = false

    public let useCase: SearchMediaUseCase

    public init(useCase: SearchMediaUseCase) {   
        self.useCase = useCase
    }

    public func search(term: String) async {
        results = [:]
        showNoResults = false

        await withTaskGroup(of: (MediaCategory, [MediaItem]).self) { group in
            for category in MediaCategory.allCases {
                group.addTask {
                    let items = try? await self.useCase.execute(term: term, category: category, limit: 5)
                    return (category, items ?? [])
                }
            }

            for await (category, items) in group where !items.isEmpty {
                results[category] = items
            }
        }

        showNoResults = results.isEmpty
    }
}
