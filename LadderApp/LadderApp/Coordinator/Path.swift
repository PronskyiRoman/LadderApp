//
//  Path.swift
//  LadderApp
//
//  Created by -_- on 26.01.2023.
//

import SwiftUI

enum Path: PathType {
    case empty
    case newGame(Coordinator)
    case scoreTable
    
    var destination: AnyView {
        switch self {
        case .empty: return AnyView(Color.pink)
        case .newGame(let coordinator): return AnyView(NewGameView(viewModel: .init(coordinator: coordinator)))
        case .scoreTable: return AnyView(Color.blue)
        }
    }
}

// MARK: Hashable
extension Path: Hashable {
    private var id: UUID {
        return UUID()
    }
    
    func hash(into hasher: inout Hasher) {
        hasher.combine(id)
    }
    
    static func == (lhs: Path, rhs: Path) -> Bool {
        lhs.id == rhs.id
    }
}

enum Path2: PathType {
    case empty
    
    var destination: AnyView {
        switch self {
        case .empty: return AnyView(Color.pink)
        }
    }
}

// MARK: Hashable
extension Path2: Hashable {
    private var id: UUID {
        return UUID()
    }
    
    func hash(into hasher: inout Hasher) {
        hasher.combine(id)
    }
}


