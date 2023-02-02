//
//  CoreDataSaveServise.swift
//  LadderApp
//
//  Created by -_- on 31.01.2023.
//

import Foundation
import CoreData

protocol CoreDataSaveServiseProtocol {
    func saveGame(player: (name: String, score: Int), opponent: (name: String, score: Int))
}

final class CoreDataSaveServise: CoreDataSaveServiseProtocol {
    private let context: NSManagedObjectContext
    
    init(context: NSManagedObjectContext) {
        self.context = context
    }
    
    func saveGame(player: (name: String, score: Int), opponent: (name: String, score: Int)) {
        let score = Score(context: context)
        let score1 = Score(context: context)
        
        let gamer1 = Player(context: context)
        let gamer2 = Player(context: context)
        
        let game = Game(context: context)
        
        gamer1.name = player.name
        gamer1.score = score
        gamer1.game = game
        
        gamer2.name = opponent.name
        gamer2.score = score1
        gamer2.game = game
        
        score.score = Int16(player.score)
        score.player = gamer1
        
        score1.score = Int16(opponent.score)
        score1.player = gamer2
        
        game.id = UUID()
        game.date = Date()
        game.players = [gamer1, gamer2]
        
        if player.score > opponent.score {
            gamer1.winner = gamer1
        } else if opponent.score > player.score {
            gamer2.winner = gamer2
        } else {
            let friend = Player(context: context)
            friend.name = "Friendship"
            gamer1.winner = friend
            
            let friend1 = Player(context: context)
            friend1.name = "Friendship"
            gamer2.winner = friend1
        }
        
        try? context.save()
    }
}
