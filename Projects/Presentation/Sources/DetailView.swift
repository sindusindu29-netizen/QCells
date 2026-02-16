//
//  DetailView.swift
//  QCells
//
//  Created by Sindhuja Gundla on 2/8/26.
//  Copyright © 2026 QCells. All rights reserved.
//

import SwiftUI
import Domain

public struct DetailView: View {
    @EnvironmentObject private var favorites: FavoritesViewModel

    public let category: MediaCategory
    public let term: String

    @StateObject private var vm: DetailViewModel

    public init(category: MediaCategory, term: String, vm: DetailViewModel) {
        self.category = category
        self.term = term
        _vm = StateObject(wrappedValue: vm)
    }

    public var body: some View {
        List(vm.items) { item in
            HStack(spacing: 12) {
                ArtworkThumbnail(url: item.artworkURL)

                VStack(alignment: .leading, spacing: 2) {
                    Text(item.title)
                        .foregroundStyle(.primary)
                        .lineLimit(2)

                    if !item.subtitle.isEmpty {
                        Text(item.subtitle)
                            .font(.caption)
                            .foregroundStyle(.secondary)
                            .lineLimit(1)
                    }
                }

                Spacer()

                FavoriteButton(
                    isFavorite: favorites.isFavorite(item.id),
                    action: { favorites.toggle(item.id) }
                )
            }
        }
        .navigationTitle(category.rawValue)
        .task {
            await vm.load(term: term, category: category)
        }
    }
}
