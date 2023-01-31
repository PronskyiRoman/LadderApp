//
//  CoreDataSaveServise.swift
//  LadderApp
//
//  Created by -_- on 31.01.2023.
//

import Foundation
import CoreData

protocol CoreDataSaveServiseProtocol {
    func saveNewTeamMember(_ name: String)
    func saveGame(playerName1: String, player1Score: Int, playerName2: String, player2Score: Int)
}

final class CoreDataSaveServise: CoreDataSaveServiseProtocol {
    private let context: NSManagedObjectContext
    
    init(context: NSManagedObjectContext) {
        self.context = context
    }
    
    func saveNewTeamMember(_ name: String) {
        let player = Player(context: context)
        player.name = name
        player.score = nil
        
        try? context.save()
    }
    
    func saveGame(playerName1: String, player1Score: Int, playerName2: String, player2Score: Int) {
        let score = Score(context: context)
        let score1 = Score(context: context)
        
        let player = Player(context: context)
        let player1 = Player(context: context)
        
        let game = Game(context: context)
        
        player.name = playerName1
        player.score = score
        player.game = game
        
        player1.name = playerName2
        player1.score = score1
        player1.game = game
        
        score.score = Int16(player1Score)
        score.player = player
        
        score1.score = Int16(player2Score)
        score1.player = player1
        
        game.id = UUID()
        game.date = Date()
        game.players = [player, player1]
        
        if player1Score > player2Score {
            player.winner = player
        } else if player2Score > player1Score {
            player1.winner = player1
        } else {
            let friend = Player(context: context)
            friend.name = "Friendship"
            player.winner = friend
            
            let friend1 = Player(context: context)
            friend1.name = "Friendship"
            player1.winner = friend1
        }
        
        try? context.save()
    }
}
