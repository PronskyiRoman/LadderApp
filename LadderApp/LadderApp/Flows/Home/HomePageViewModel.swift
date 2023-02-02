//
//  HomePageViewModel.swift
//  LadderApp
//
//  Created by -_- on 31.01.2023.
//

import SwiftUI
import CoreData

final class HomePageViewModel: HomePageViewModelProtocol {
    // context
    let context: NSManagedObjectContext
    
    // constants
    var navTitle: String = StringsConstants.homeNavTitle
    var playTitle: String = StringsConstants.playNewGameButtonTitle
    var viewScoreTitle: String = StringsConstants.viewScoreButtonTitle
    
    // ui
    var buttonColor: Color = ColorConstants.button
    var backgroundColor: Color = ColorConstants.background
    var buttonFont: Font = FontConstants.title
    
    // coordinator
    var coordinator: Coordinator
    
    // init
    init(coordinator: Coordinator, context: NSManagedObjectContext) {
        self.coordinator = coordinator
        self.context = context
        initialSetup()
    }
    
    // navigation
    func pushNewGame() {
        coordinator.push(path: .newGame(coordinator))
    }
    
    func pushScoreTable() {
        coordinator.push(path: .scoreTable(context))
    }
    
    // setup preloaded Score as required
    private func initialSetup() {
        guard UserDefaultsStorage().get(key: .isFirstLoading, defaultValue: true) else { return }
        UserDefaultsStorage().set(key: .isFirstLoading, value: false)
        let servise = CoreDataSaveServise(context: context)
        var initialData = [(player: (name: String, score: Int), opponent: (name: String, score: Int))]()
        initialData.append((player: (name: "Amos", score: 4), opponent: (name: "Diego", score: 5)))
        initialData.append((player: (name: "Amos", score: 1), opponent: (name: "Diego", score: 5)))
        initialData.append((player: (name: "Amos", score: 2), opponent: (name: "Diego", score: 5)))
        initialData.append((player: (name: "Amos", score: 0), opponent: (name: "Diego", score: 5)))
        initialData.append((player: (name: "Amos", score: 6), opponent: (name: "Diego", score: 5)))
        initialData.append((player: (name: "Amos", score: 5), opponent: (name: "Diego", score: 2)))
        initialData.append((player: (name: "Amos", score: 4), opponent: (name: "Diego", score: 0)))
        initialData.append((player: (name: "Joel", score: 4), opponent: (name: "Diego", score: 5)))
        initialData.append((player: (name: "Tim", score: 4), opponent: (name: "Amos", score: 5)))
        initialData.append((player: (name: "Tim", score: 5), opponent: (name: "Amos", score: 2)))
        initialData.append((player: (name: "Amos", score: 4), opponent: (name: "Tim", score: 5)))
        initialData.append((player: (name: "Amos", score: 5), opponent: (name: "Tim", score: 3)))
        initialData.append((player: (name: "Amos", score: 5), opponent: (name: "Joel", score: 4)))
        initialData.append((player: (name: "Joel", score: 5), opponent: (name: "Tim", score: 2)))
        
        initialData.forEach({
            servise.saveGame(player: $0.player, opponent: $0.opponent)
        })
    }
}
