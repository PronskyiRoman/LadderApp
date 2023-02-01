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
    
    // UI
    @Published var isStartDisabled: Bool = true
    
    // constants
    var titleColor: Color = ColorConstants.button
    var textColor: Color = ColorConstants.text
    var errorTextColor: Color = ColorConstants.error
    var backgroundColor: Color = ColorConstants.background
    var textFieldBackgroundColor: Color = ColorConstants.textFieldBackground
    var backTitle: String = StringsConstants.back
    var title: String = StringsConstants.selectPlayersTitle
    var selectPlayerPlaceholder: String = StringsConstants.selectPlayer
    var enterNewPlayerNamePlaceholder: String = StringsConstants.newPlayerPlaceholder
    var startButtonTitle: String = StringsConstants.start
    var titleFont: Font = FontConstants.title
    var font: Font = FontConstants.erroe
    
    // first player
    @Published var isFirstPlayerNew: Bool = false
    @Published var firstPlayerName: String = ""
    @Published var firstPlayerErrorMessage: String = ""
    var firstPlayerNameBinding: Binding<String>
    
    // second player
    @Published var isSecondPlayerNew: Bool = false
    @Published var secondPlayerName: String = ""
    @Published var secondPlayerErrorMessage: String = ""
    var secondPlayerNameBinding: Binding<String>
    
    // all players
    @Published private var chosenFirstPlayer: String = ""
    @Published private var chosenSecondPlayer: String = ""
    @Published var allPlayers: [String] = ["Jack", "Merry", "Garry"]
    
    // combine
    var cancellable: Set<AnyCancellable> = .init()
    
    // navigation
    var coordinator: Coordinator
    
    // init
    init(coordinator: Coordinator) {
        self.isSheetPresentedBinding = .constant(false)
        self.firstPlayerNameBinding = .constant("")
        self.secondPlayerNameBinding = .constant("")
        self.coordinator = coordinator
        bind()
    }
    
    func bind() {
        $isSheetPresented.sink(receiveValue: { [weak self] value in
            guard let self else { return }
            self.isSheetPresentedBinding = Binding(get: { value }, set: { self.isSheetPresented = $0 })
        }).store(in: &cancellable)
        
        $firstPlayerName.sink(receiveValue: { [weak self] name in
            guard let self else { return }
            self.firstPlayerNameBinding = Binding(get: { name }, set: { self.firstPlayerName = $0 })
            self.chosenFirstPlayer = name
            self.firstPlayerErrorMessage = self.isFirstPlayerNew && self.allPlayers.contains(where: { $0 == name }) ? "Player already Exist" : ""
            self.isStartDisabled = self.isStartAllowed()
        }).store(in: &cancellable)
        
        $secondPlayerName.sink(receiveValue: { [weak self] name in
            guard let self else { return }
            self.secondPlayerNameBinding = Binding(get: { name }, set: { self.secondPlayerName = $0 })
            self.chosenSecondPlayer = name
            self.secondPlayerErrorMessage = self.isSecondPlayerNew && self.allPlayers.contains(where: { $0 == name }) ? "Player already Exist" : ""
            self.isStartDisabled = self.isStartAllowed()
        }).store(in: &cancellable)
    }
    
    func checkIsPlayersSelected() {
//        isSheetPresented = true
        
    }
    
    func playerIsNew(isFirst: Bool) {
        guard isFirst else {
            secondPlayerName = ""
            isSecondPlayerNew.toggle()
            return
        }
        
        firstPlayerName = ""
        isFirstPlayerNew.toggle()
    }
    
    func isChosenPlayerDisabled(name: String) -> Bool {
        chosenFirstPlayer == name || chosenSecondPlayer == name
    }
    
    func isChosenPlayerDisabled(isPlayerFirst: Bool) -> Color {
        if isPlayerFirst && !firstPlayerErrorMessage.isEmpty {
            return errorTextColor
        }
        
        if !isPlayerFirst && !secondPlayerErrorMessage.isEmpty {
            return errorTextColor
        }
        
        return textColor
    }
    
    private func isStartAllowed() -> Bool {
        !(firstPlayerErrorMessage.isEmpty
        && secondPlayerErrorMessage.isEmpty
        && !chosenFirstPlayer.isEmpty
        && !chosenSecondPlayer.isEmpty)
    }
    
    func startButtonColor() -> Color {
        isStartDisabled ? ColorConstants.disabled : ColorConstants.button
    }
    
    func startButtonTitleColor() -> Color {
        isStartDisabled ? titleColor : textColor
    }
    
    func switchButtonTitle(isNew: Bool) -> String {
        isNew ? StringsConstants.oldPlayer : StringsConstants.newPlayer
    }
    
    func backAction() {
        isSheetPresented.toggle()
        coordinator.popLast()
    }
    
    func startAction() {
        //
    }
}
