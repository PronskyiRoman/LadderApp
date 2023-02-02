//
//  PlayerScore.swift
//  LadderApp
//
//  Created by -_- on 02.02.2023.
//

import Foundation

struct PlayerScore: Identifiable, Hashable {
    let id = UUID()
    let name: String
    let gamesPlayed: Int
    let gamesWinned: Int
    
    var winRate: Int {
        if gamesPlayed > 0 {
            return Int(Double(gamesWinned) / Double(gamesPlayed) * Double(100))
        }
        
        return 0
    }
}
