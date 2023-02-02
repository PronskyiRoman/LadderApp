//
//  SelectPlayersViewModel.swift
//  LadderApp
//
//  Created by -_- on 02.02.2023.
//

import SwiftUI
import Combine
import CoreData

final class SelectPlayersViewModel: ObservableObject, SelectPlayersViewModelProtocol {
    // is presented
    @Binding var isSheetPresentedBinding: Bool
    
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
    @Published var firstPlayerName: String
    @Published var firstPlayerErrorMessage: String = ""
    var firstPlayerNameBinding: Binding<String>
    
    // second player
    @Published var isSecondPlayerNew: Bool = false
    @Published var secondPlayerName: String
    @Published var secondPlayerErrorMessage: String = ""
    var secondPlayerNameBinding: Binding<String>
    
    // all players
    @Published private var chosenFirstPlayer: String = ""
    @Published private var chosenSecondPlayer: String = ""
    @Published var allPlayers: [String] = ["Jack", "Merry", "Garry"]
    
    // combine
    var cancellable: Set<AnyCancellable> = .init()
    
    // servises
    var coreData: CoreDataRequestsServise
    var coreDataSave: CoreDataSaveServise
    
    // navigation
    var coordinator: Coordinator
    
    // init
    init(coordinator: Coordinator, isPresented: Binding<Bool>,
         context: NSManagedObjectContext,
         firstPlayerName: Published<String>, secondPlayerName: Published<String>) {
        _isSheetPresentedBinding = isPresented
        self.firstPlayerNameBinding = .constant("")
        self.secondPlayerNameBinding = .constant("")
        self.coordinator = coordinator
        self.coreData = .init(context: context)
        self.coreDataSave = .init(context: context)
        _firstPlayerName = firstPlayerName
        _secondPlayerName = secondPlayerName
        bind()
        loadPlayers()
    }
    
    func bind() {
        $firstPlayerName.sink(receiveValue: { [weak self] name in
            guard let self else { return }
            self.firstPlayerNameBinding = Binding(get: { name }, set: { self.firstPlayerName = $0 })
            self.chosenFirstPlayer = name
            self.checkPlayers(isFirst: true, player: name)
            self.isStartDisabled = self.isStartAllowed()
        }).store(in: &cancellable)
        
        $secondPlayerName.sink(receiveValue: { [weak self] name in
            guard let self else { return }
            self.secondPlayerNameBinding = Binding(get: { name }, set: { self.secondPlayerName = $0 })
            self.chosenSecondPlayer = name
            self.checkPlayers(isFirst: false, player: name)
            self.isStartDisabled = self.isStartAllowed()
        }).store(in: &cancellable)
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
        
        if chosenFirstPlayer == chosenSecondPlayer && !chosenFirstPlayer.isEmpty && !chosenSecondPlayer.isEmpty {
            return errorTextColor
        }
        
        return textColor
    }
    
    private func isStartAllowed() -> Bool {
        !(firstPlayerErrorMessage.isEmpty
        && secondPlayerErrorMessage.isEmpty
        && !chosenFirstPlayer.isEmpty
        && !chosenSecondPlayer.isEmpty
        && chosenFirstPlayer != chosenSecondPlayer)
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
        isSheetPresentedBinding.toggle()
        coordinator.popLast()
    }
    
    func loadPlayers() {
        allPlayers = coreData.allMembers()
    }
    
    func startAction() {
        savePlayer()
        isSheetPresentedBinding.toggle()
    }
    
    private func savePlayer() {
        if !chosenFirstPlayer.isEmpty && !chosenSecondPlayer.isEmpty {
            if !allPlayers.contains(chosenFirstPlayer) { coreDataSave.saveNewTeamMember(chosenFirstPlayer) }
            if !allPlayers.contains(chosenSecondPlayer) { coreDataSave.saveNewTeamMember(chosenSecondPlayer) }
        }
    }
    
    private func checkPlayers(isFirst: Bool, player: String) {
        let errorMessage = StringsConstants.errorPlayerExistOrChosen
        
        if isFirst {
            firstPlayerErrorMessage = isFirstPlayerNew && allPlayers.contains(where: { $0 == player })
            || (chosenFirstPlayer == chosenSecondPlayer && (!chosenFirstPlayer.isEmpty && !chosenSecondPlayer.isEmpty)) ? errorMessage : ""
        } else {
            secondPlayerErrorMessage = isSecondPlayerNew && allPlayers.contains(where: { $0 == player })
            || (chosenFirstPlayer == chosenSecondPlayer && (!chosenFirstPlayer.isEmpty && !chosenSecondPlayer.isEmpty)) ? errorMessage : ""
        }
    }
}
