//
//  NewGameViewModel.swift
//  LadderApp
//
//  Created by -_- on 31.01.2023.
//

import SwiftUI
import Combine

final class NewGameViewModel: ObservableObject, NewGameViewModelProtocol {
    // screen should be presented on appear
    @Published var isSheetPresented: Bool = true
    var isSheetPresentedBinding: Binding<Bool>
   
    // combine
    var cancellable: Set<AnyCancellable> = .init()
    
    // players
    var firstPlayerName: Published<String>
    var secondPlayerName: Published<String>
    var firstPlayerNameString: String = ""
    var secondPlayerNameString: String = ""
    
    // navigation
    var coordinator: Coordinator
    
    init(coordinator: Coordinator) {
        self.isSheetPresentedBinding = .constant(true)
        self.coordinator = coordinator
        self.firstPlayerName = .init(initialValue: "")
        self.secondPlayerName = .init(initialValue: "")
        bind() 
    }
    
    func bind() {
        $isSheetPresented.sink(receiveValue: { [weak self] value in
            guard let self else { return }
            self.isSheetPresentedBinding = Binding(get: { value }, set: { self.isSheetPresented = $0 })
        }).store(in: &cancellable)
        
        firstPlayerName.projectedValue.sink(receiveValue: { [weak self] value in
            self?.firstPlayerNameString = value
        }).store(in: &cancellable)
        
        secondPlayerName.projectedValue.sink(receiveValue: { [weak self] value in
            self?.secondPlayerNameString = value
        }).store(in: &cancellable)
    }
    
    func checkIsPlayersSelected() {
        if firstPlayerNameString.isEmpty && secondPlayerNameString.isEmpty {
            coordinator.popLast()
        }
    }
}
