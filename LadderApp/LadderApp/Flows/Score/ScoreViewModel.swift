//
//  ScoreViewModel.swift
//  LadderApp
//
//  Created by -_- on 02.02.2023.
//

import SwiftUI
import CoreData

final class ScoreViewModel: ObservableObject, ScoreViewModelProtocol {
    // UI constants
    var navigationTitle: String = StringsConstants.scoreNavTitle
    var textColor: Color = ColorConstants.text
    var fontText: Font = FontConstants.averageText
    var fontDescription: Font = FontConstants.erroe
    var playerSectionHeader: String = StringsConstants.player
    var winRateSectionHeader: String = StringsConstants.winRate
    var gamesSectionHeader: String = StringsConstants.games
    var backgroundColor: Color = ColorConstants.background
    var headerBackgroundColor: Color = ColorConstants.disabled
    
    // data
    var players: [PlayerScore]
    
    // servises
    var coreData: CoreDataRequestsServise
    
    init(context: NSManagedObjectContext) {
        coreData = .init(context: context)
        players = []
        players = loadPlayers()
    }
    
    func imageFor(rate winRate: Int) -> Image {
        var imageName = ""
        switch winRate {
        case (76...100): imageName = "arrow.up.heart"
        case (51...75): imageName = "arrow.up.message"
        case (31...50): imageName = "dock.arrow.up.rectangle"
        case (11...30): imageName = "arrow.up.bin"
        case (0...10): imageName = "water.waves.and.arrow.up"
        case (-100 ... -1): imageName = "water.waves.and.arrow.down.trianglebadge.exclamationmark"
        default: imageName = "exclamationmark.icloud"
        }
        
        return Image(systemName: imageName)
    }
    
    func winRateForeground(rate winRate: Int) -> Color {
        switch winRate {
        case (76...100): return ColorConstants.winner
        case (51...75): return ColorConstants.standOff
        case (31...50): return ColorConstants.standOff
        case (11...30): return ColorConstants.orange
        case (0...10): return ColorConstants.error
        case (-100 ... -1): return ColorConstants.hugeError
        default: return ColorConstants.text
        }
    }
    
    private func loadPlayers() -> [PlayerScore] {
        [
            PlayerScore(name: "Hello \(Int.random(in: 1..<300))", gamesPlayed: .random(in: 1..<300), gamesWinned: .random(in: 1..<300)),
            PlayerScore(name: "Hello \(Int.random(in: 1..<300))", gamesPlayed: .random(in: 1..<300), gamesWinned: .random(in: 1..<300)),
            PlayerScore(name: "Hello \(Int.random(in: 1..<300))", gamesPlayed: .random(in: 1..<300), gamesWinned: .random(in: 1..<300)),
            PlayerScore(name: "Hello \(Int.random(in: 1..<300))", gamesPlayed: .random(in: 1..<300), gamesWinned: .random(in: 1..<300)),
            PlayerScore(name: "Hello \(Int.random(in: 1..<300))", gamesPlayed: .random(in: 1..<300), gamesWinned: .random(in: 1..<300)),
            PlayerScore(name: "Hello \(Int.random(in: 1..<300))", gamesPlayed: .random(in: 1..<300), gamesWinned: .random(in: 1..<300)),
            PlayerScore(name: "Hello \(Int.random(in: 1..<300))", gamesPlayed: .random(in: 1..<300), gamesWinned: .random(in: 1..<300)),
            PlayerScore(name: "Hello \(Int.random(in: 1..<300))", gamesPlayed: .random(in: 1..<300), gamesWinned: .random(in: 1..<300)),
            PlayerScore(name: "Hello \(Int.random(in: 1..<300))", gamesPlayed: .random(in: 1..<300), gamesWinned: .random(in: 1..<300)),
            PlayerScore(name: "Hello \(Int.random(in: 1..<300))", gamesPlayed: .random(in: 1..<300), gamesWinned: .random(in: 1..<300)),
            PlayerScore(name: "Hello \(Int.random(in: 1..<300))", gamesPlayed: .random(in: 1..<300), gamesWinned: .random(in: 1..<300)),
            PlayerScore(name: "Hello \(Int.random(in: 1..<300))", gamesPlayed: .random(in: 1..<300), gamesWinned: .random(in: 1..<300)),
        ]
    }
}
