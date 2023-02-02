//
//  NewGameViewModelProtocol.swift
//  LadderApp
//
//  Created by -_- on 31.01.2023.
//

import SwiftUI
import Combine

protocol NewGameViewModelProtocol: ObservableObject {
    var isSheetPresented: Bool { get set }
    var isSheetPresentedBinding: Binding<Bool> { get set }
    
    var isBackSheetPresented: Bool { get set }
    var isBackSheetPresentedBinding: Binding<Bool> { get set }
    
    // players
    // first
    var firstPlayerName: Published<String> { get set }
    var firstPlayerNameString: String { get set }
    var firstPlayerScore: Int { get set }
    var firstPlayerForeground: Color { get set }
    
    // second
    var secondPlayerName: Published<String> { get set }
    var secondPlayerNameString: String { get set }
    var secondPlayerScore: Int { get set }
    var secondPlayerForeground: Color { get set }
    
    // UI
    // constants
    var endGameButtonTitle: String { get set }
    var gameScoreTitile: String { get set }
    var scoreSeparatorTitle: String { get set }
    var errorGameHasNotBeenSaved: String { get set }
    var saveTitle: String { get set }
    var backTitle: String { get set }
    var leaveTitle: String { get set }
    
    // combine
    var cancellable: Set<AnyCancellable> { get set }
    func bind()
    
    // navigation
    var coordinator: Coordinator { get set }
    
    // func
    func checkIsPlayersSelected()
    func updateScore(for player: String)
    func firstLetter(of name: String) -> String
    func endGame()
    func leave()
    func backAction()
}
