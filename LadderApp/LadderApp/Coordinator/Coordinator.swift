//
//  Coordinator.swift
//  LadderApp
//
//  Created by -_- on 26.01.2023.
//

import SwiftUI

final class Coordinator: AnyCoordinatable {
    @Published var path = NavigationPath()
    static let shared: Coordinator = {
        Coordinator()
    }()
    
    private init() { }
    
    func push(path: Path) {
        self.path.append(path)
    }
    
    func popToRoot() {
        path = NavigationPath()
    }
}

// MARK: Hashable
extension Coordinator {
    static func == (lhs: Coordinator, rhs: Coordinator) -> Bool {
        lhs.id == rhs.id
    }
    
    func hash(into hasher: inout Hasher) {
        hasher.combine(id)
    }
}
