//
//  HomePageViewModel.swift
//  LadderApp
//
//  Created by -_- on 31.01.2023.
//

import SwiftUI

final class HomePageViewModel: HomePageViewModelProtocol {
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
    init(coordinator: Coordinator) {
        self.coordinator = coordinator
    }
    
    // navigation
    func pushNewGame() {
        coordinator.push(path: .newGame(coordinator))
    }
    
    func pushScoreTable() {
        coordinator.push(path: .scoreTable)
    }
}
