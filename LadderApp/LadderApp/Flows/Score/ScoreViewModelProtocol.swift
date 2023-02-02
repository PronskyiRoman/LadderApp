//
//  ScoreViewModelProtocol.swift
//  LadderApp
//
//  Created by -_- on 02.02.2023.
//

import SwiftUI

protocol ScoreViewModelProtocol: ObservableObject {
    // UI constants
    var navigationTitle: String { get set }
    var textColor: Color { get set }
    var fontText: Font { get set }
    var fontDescription: Font { get set }
    var playerSectionHeader: String { get set }
    var winRateSectionHeader: String { get set }
    var gamesSectionHeader: String { get set }
    var emptyViewTitle: String { get set }
    var backgroundColor: Color { get set }
    var headerBackgroundColor: Color { get set }
    
    func imageFor(rate winRate: Int) -> Image
    func winRateForeground(rate winRate: Int) -> Color
    
    // players
    var players: [PlayerScore] { get set }
    
    // core data
    var coreData: CoreDataRequestsServise { get set }
}
