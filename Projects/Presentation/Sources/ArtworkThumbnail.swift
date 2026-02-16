//
//  ArtworkThumbnail.swift
//  QCells
//
//  Created by Sindhuja Gundla on 2/8/26.
//  Copyright © 2026 QCells. All rights reserved.
//

import SwiftUI

struct ArtworkThumbnail: View {
    let url: URL?

    var body: some View {
        AsyncImage(url: url, transaction: Transaction(animation: .default)) { phase in
            switch phase {
            case .empty:
                RoundedRectangle(cornerRadius: 8)
                    .fill(.quaternary)
                    .frame(width: 44, height: 44)

            case .success(let image):
                image
                    .resizable()
                    .scaledToFill()
                    .frame(width: 44, height: 44)
                    .clipShape(RoundedRectangle(cornerRadius: 8))

            case .failure:
                RoundedRectangle(cornerRadius: 8)
                    .fill(.quaternary)
                    .overlay {
                        Image(systemName: "photo")
                            .foregroundStyle(.secondary)
                    }
                    .frame(width: 44, height: 44)

            @unknown default:
                EmptyView()
            }
        }
        .accessibilityHidden(true)
    }
}

