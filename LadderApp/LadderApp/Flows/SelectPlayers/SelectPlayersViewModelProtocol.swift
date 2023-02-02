//
//  SelectPlayersViewModelProtocol.swift
//  LadderApp
//
//  Created by -_- on 02.02.2023.
//

import SwiftUI
import Combine

protocol SelectPlayersViewModelProtocol: ObservableObject {
    // UI
    var isStartDisabled: Bool { get set }
    
    // Constants
    var titleColor: Color { get set }
    var textColor: Color { get set }
    var errorTextColor: Color { get set }
    var backgroundColor: Color { get set }
    var textFieldBackgroundColor: Color { get set }
    func startButtonColor() -> Color
    func startButtonTitleColor() -> Color
    var backTitle: String { get set }
    var title: String { get set }
    func switchButtonTitle(isNew: Bool) -> String
    var selectPlayerPlaceholder: String { get set }
    var enterNewPlayerNamePlaceholder: String { get set }
    var startButtonTitle: String { get set }
    var titleFont: Font { get set }
    var font: Font { get set }
    
    // First Player
    var isFirstPlayerNew: Bool { get set }
    var firstPlayerName: String { get set }
    var firstPlayerNameBinding: Binding<String> { get set }
    var firstPlayerErrorMessage: String { get set }
    
    // Second Player
    var isSecondPlayerNew: Bool { get set }
    var secondPlayerName: String { get set }
    var secondPlayerNameBinding: Binding<String> { get set }
    var secondPlayerErrorMessage: String { get set }
    
    func playerIsNew(isFirst: Bool)
    
    // players
    var allPlayers: [String] { get set }
    func isChosenPlayerDisabled(name: String) -> Bool
    func isChosenPlayerDisabled(isPlayerFirst: Bool) -> Color
    
    // combine
    var cancellable: Set<AnyCancellable> { get set }
    func bind()
    
    // navigation
    var coordinator: Coordinator { get set }
    
    // servises
    var coreData: CoreDataRequestsServise { get set }
    
    // func
    func backAction()
    func startAction()
    func loadPlayers()
}
