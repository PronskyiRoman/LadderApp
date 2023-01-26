//
//  LadderAppApp.swift
//  LadderApp
//
//  Created by -_- on 23.01.2023.
//

import SwiftUI

@main
struct LadderAppApp: App {
    @StateObject private var coreDataManager: CoreDataManager = .shared
    
    var body: some Scene {
        WindowGroup {
            let contentViewModel = ContentViewModel.init()
            ContentView(viewModel: contentViewModel, coordinator: contentViewModel.coordinator)
                .environment(\.managedObjectContext, coreDataManager.context)
        }
    }
}
