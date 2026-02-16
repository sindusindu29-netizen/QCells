//
//  FavoritesStore.swift
//  QCells
//
//  Created by Sindhuja Gundla on 2/8/26.
//  Copyright © 2026 QCells. All rights reserved.
//

import Foundation

public actor FavoritesStore {
    private var favorites: Set<Int64> = []

    public init() {}

    public func isFavorite(_ id: Int64) -> Bool {
        favorites.contains(id)
    }

    public func toggle(_ id: Int64) -> Bool {
        if favorites.contains(id) {
            favorites.remove(id)
            return false
        } else {
            favorites.insert(id)
            return true
        }
    }

    public func all() -> Set<Int64> {
        favorites
    }
}
