//
//  HomePageViewModelProtocol.swift
//  LadderApp
//
//  Created by -_- on 31.01.2023.
//

import SwiftUI

protocol HomePageViewModelProtocol: ObservableObject {
    // constants
    var navTitle: String { get set }
    var playTitle: String { get set }
    var viewScoreTitle: String { get set }
    
    // UI
    var buttonColor: Color { get set }
    var backgroundColor: Color { get set }
    var buttonFont: Font { get set }
    
    // navigation
    var coordinator: Coordinator { get set }
    func pushNewGame()
    func pushScoreTable()
}
