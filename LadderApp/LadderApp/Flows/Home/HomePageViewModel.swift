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
    }
    
    // navigation
    func pushNewGame() {
        coordinator.push(path: .newGame(coordinator))
    }
    
    func pushScoreTable() {
        coordinator.push(path: .scoreTable(context))
    }
}
