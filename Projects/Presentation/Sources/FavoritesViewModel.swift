//
//  FavoritesViewModel.swift
//  QCells
//
//  Created by Sindhuja Gundla on 2/8/26.
//  Copyright © 2026 QCells. All rights reserved.
//
import SwiftUI
import Data

@MainActor
public final class FavoritesViewModel: ObservableObject {
    @Published public private(set) var favoriteIDs: Set<Int64> = []

    private let store: FavoritesStore

    public init(store: FavoritesStore = FavoritesStore()) {
        self.store = store
    }

    public func isFavorite(_ id: Int64) -> Bool {
        favoriteIDs.contains(id)
    }

    public func toggle(_ id: Int64) {                          
        Task {
            _ = await store.toggle(id)
            favoriteIDs = await store.all()
        }
    }
}
