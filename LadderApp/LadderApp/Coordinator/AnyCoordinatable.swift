//
//  AnyCoordinatable.swift
//  LadderApp
//
//  Created by -_- on 26.01.2023.
//

import SwiftUI

protocol AnyCoordinatable: AnyObject, ObservableObject, Hashable {
    associatedtype CoordinatorPath: PathType
    var id: UUID { get }
    var path: NavigationPath { get set }
    
    func popToRoot()
    func push(path: CoordinatorPath)
}

extension AnyCoordinatable {
    var id: UUID { UUID() }
    
    func push(path: CoordinatorPath) {
        self.path.append(path)
    }
}

