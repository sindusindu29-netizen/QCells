//
//  DetailView.swift
//  QCells
//
//  Created by Sindhuja Gundla on 2/8/26.
//  Copyright © 2026 QCells. All rights reserved.
//

import SwiftUI
import Domain

public struct HomeView: View {
    @EnvironmentObject private var favorites: FavoritesViewModel

    @StateObject private var vm: HomeViewModel
    @State private var searchText = ""
    @State private var isSearching = false

    public init(vm: HomeViewModel) {
        _vm = StateObject(wrappedValue: vm)
    }

    public var body: some View {
        List {
            ForEach(MediaCategory.allCases, id: \.self) { category in
                if let items = vm.results[category], !items.isEmpty {
                    Section {
                        ForEach(items) { item in
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
                    } header: {
                        NavigationLink {
                            DetailView(
                                category: category,
                                term: searchText,
                                vm: DetailViewModel(useCase: vm.useCase)
                            )
                        } label: {
                            HStack(spacing: 8) {
                                Text(category.rawValue)
                                    .foregroundStyle(.primary)

                                Spacer()

                                Image(systemName: "chevron.right")
                                    .font(.body)
                                    .fontWeight(.semibold)
                                    .foregroundStyle(.secondary)
                            }
                            .contentShape(Rectangle())
                        }
                        .buttonStyle(.plain)
                    }
                }
            }
        }
        .listStyle(.insetGrouped)
        .navigationTitle("Main")
        .searchable(
            text: $searchText,
            isPresented: $isSearching,
            placement: .navigationBarDrawer(displayMode: .always),
            prompt: "Search"
        )
        .onSubmit(of: .search) {
            Task { await vm.search(term: searchText) }
        }
        .overlay {
            if vm.showNoResults {
                Text("No results found")
                    .foregroundStyle(.secondary)
            }
        }
    }
}

