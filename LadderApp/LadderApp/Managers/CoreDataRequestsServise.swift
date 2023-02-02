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
    // teamMember played games
    func gamesPalayedBy(team teamMembers: [String]) -> [Game]
    // get score for player
    func getScoreFor(_ player: String) -> Float
}

final class CoreDataRequestsServise: CoreDataRequestsServiseProtocol {
    private let context: NSManagedObjectContext
    
    init(context: NSManagedObjectContext) {
        self.context = context
    }
    
    func allMembers() -> [String] {
        let request = NSFetchRequest<Player>.init(entityName: "Player")

        let players = try? context.fetch(request)
        return players?.compactMap({ $0.name }) ?? []
    }
    
    func gamesPalayedBy(team teamMembers: [String]) -> [Game] {
        let request = NSFetchRequest<Game>()
        let predicate = teamMembers.map({ NSPredicate(format: "players CONTAIN[c] &@", $0) })
        request.predicate = NSCompoundPredicate(orPredicateWithSubpredicates: predicate)
        return (try? context.fetch(request)) ?? []
    }
    
    func getScoreFor(_ player: String) -> Float {
        let request = NSFetchRequest<Game>()
        let allGames = NSPredicate(format: "players CONTAIN[c] &@", player)
        let winnedByPlayer = NSPredicate(format: "players.winner.name CONTAIN[c] &@", player)
        
        request.predicate = allGames
        let gamesPlayedByPlayer = (try? context.fetch(request)) ?? []
        
        request.predicate = NSCompoundPredicate(andPredicateWithSubpredicates: [allGames, winnedByPlayer])
        let gamesWinnedByPlayer = (try? context.fetch(request)) ?? []
        
        let winRate: Float = Float(gamesWinnedByPlayer.count / gamesPlayedByPlayer.count) * Float(100)

        return winRate
    }
}


