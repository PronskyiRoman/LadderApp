//
//  CoreDataRequestsServise.swift
//  LadderApp
//
//  Created by -_- on 26.01.2023.
//

import Foundation
import CoreData

protocol CoreDataRequestsServiseProtocol {
    // all members
    func allMembers() -> [String]
    // get score table
    func getScoreTable() -> [PlayerScore]
}

final class CoreDataRequestsServise: CoreDataRequestsServiseProtocol {
    private let context: NSManagedObjectContext
    
    init(context: NSManagedObjectContext) {
        self.context = context
    }
    
    func allMembers() -> [String] {
        let request = NSFetchRequest<Player>.init(entityName: "Player")

        let players = try? context.fetch(request)
        var set = Array(Set(players?.compactMap({ $0.name }) ?? []))
        set.removeAll(where: { $0 == "Friendship" })
        return set
    }
    
    private func getScoreFor(_ player: String) -> PlayerScore {
        let request = NSFetchRequest<Game>.init(entityName: "Game")
        let games = (try? context.fetch(request)) ?? []
        
        var gamesPlayedByPlayer = 0
        games.forEach({ game in
            guard let players = game.players as? Set<Player> else { return }
            guard players.contains(where: { $0.name == player }) else { return }
            gamesPlayedByPlayer += 1
        })
        
        var gamesWinnedByPlayer = 0
        games.forEach({ game in
            guard let players = game.players as? Set<Player> else { return }
            guard players.contains(where: { $0.winner?.name == player }) else { return }
            gamesWinnedByPlayer += 1
        })

        return PlayerScore(name: player, gamesPlayed: gamesPlayedByPlayer, gamesWinned: gamesWinnedByPlayer)
    }
    
    func getScoreTable() -> [PlayerScore] {
        let allMembers = allMembers()
        var scoreTable: [PlayerScore] = []
        allMembers.forEach({ scoreTable.append(getScoreFor($0)) })
        
        return scoreTable
    }
}


