//
//  App.swift
//  QCells
//
//  Created by QCells.
//  Copyright © 2025 QCells. All rights reserved.
//

import SwiftUI
import Presentation
import Domain
import Data

@main
struct QcellsApp: App {
    @StateObject private var favoritesVM = FavoritesViewModel()

    var body: some Scene {
        WindowGroup {
            let repository = MediaRepositoryImpl()
            let useCase = SearchMediaUseCase(repository: repository)
            let homeVM = HomeViewModel(useCase: useCase)

            NavigationStack {
                HomeView(vm: homeVM)
            }
            .tint(.blue)
            .environmentObject(favoritesVM)
        }
    }
}

