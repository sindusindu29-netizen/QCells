//
//  DetailViewModel.swift
//  QCells
//
//  Created by Sindhuja Gundla on 2/8/26.
//  Copyright © 2026 QCells. All rights reserved.
//

import SwiftUI
import Domain

@MainActor
public final class DetailViewModel: ObservableObject {
    @Published public var items: [MediaItem] = []

    private let useCase: SearchMediaUseCase

    public init(useCase: SearchMediaUseCase) {
        self.useCase = useCase
    }

    public func load(term: String, category: MediaCategory) async {
        let items = try? await useCase.execute(term: term, category: category, limit: nil)
        self.items = items ?? []
    }
}

