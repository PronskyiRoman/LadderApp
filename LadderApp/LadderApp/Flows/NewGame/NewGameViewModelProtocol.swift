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
    
    // players
    var firstPlayerName: Published<String> { get set }
    var secondPlayerName: Published<String> { get set }
    var firstPlayerNameString: String { get set }
    var secondPlayerNameString: String { get set }
    
    // combine
    var cancellable: Set<AnyCancellable> { get set }
    func bind()
    
    // navigation
    var coordinator: Coordinator { get set }
    
    // func
    func checkIsPlayersSelected()
}
