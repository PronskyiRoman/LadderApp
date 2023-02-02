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
    @Published var isBackSheetPresented: Bool = false
    var isBackSheetPresentedBinding: Binding<Bool>
   
    // combine
    var cancellable: Set<AnyCancellable> = .init()
    
    // players
    var firstPlayerName: Published<String>
    var secondPlayerName: Published<String>
    var firstPlayerNameString: String = ""
    var secondPlayerNameString: String = ""
    @Published var firstPlayerScore: Int = 0
    @Published var secondPlayerScore: Int = 0
    @Published var firstPlayerForeground: Color = .black
    @Published var secondPlayerForeground: Color = .black
    
    // UI constants
    var endGameButtonTitle: String = StringsConstants.endGameTitile
    var gameScoreTitile: String = StringsConstants.gameScoreTitle
    var scoreSeparatorTitle: String = StringsConstants.scoreSeparator
    var errorGameHasNotBeenSaved: String = StringsConstants.errorGameHasNotBeenSaved
    var saveTitle: String = StringsConstants.save
    var backTitle: String = StringsConstants.back
    var leaveTitle: String = StringsConstants.leave
    
    // navigation
    var coordinator: Coordinator
    
    init(coordinator: Coordinator) {
        self.isSheetPresentedBinding = .constant(true)
        self.isBackSheetPresentedBinding = .constant(false)
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
        
        $isBackSheetPresented.sink(receiveValue: { [weak self] value in
            guard let self else { return }
            self.isBackSheetPresentedBinding = Binding(get: { value }, set: { self.isBackSheetPresented = $0 })
        }).store(in: &cancellable)
        
        firstPlayerName.projectedValue.sink(receiveValue: { [weak self] value in
            self?.firstPlayerNameString = value
        }).store(in: &cancellable)
        
        secondPlayerName.projectedValue.sink(receiveValue: { [weak self] value in
            self?.secondPlayerNameString = value
        }).store(in: &cancellable)
        
        $firstPlayerScore.sink(receiveValue: { [weak self] score in
            guard let self else { return }
            self.firstPlayerForeground = self.compareScores(score, with: self.secondPlayerScore)
            self.secondPlayerForeground = self.compareScores(self.secondPlayerScore, with: score)
        }).store(in: &cancellable)
        
        $secondPlayerScore.sink(receiveValue: { [weak self] score in
            guard let self else { return }
            self.secondPlayerForeground = self.compareScores(score, with: self.firstPlayerScore)
            self.firstPlayerForeground = self.compareScores(self.firstPlayerScore, with: score)
        }).store(in: &cancellable)
    }
    
    func checkIsPlayersSelected() {
        if firstPlayerNameString.isEmpty || secondPlayerNameString.isEmpty {
            coordinator.popLast()
        }
    }
    
    func updateScore(for player: String) {
        guard player == firstPlayerNameString else {
            secondPlayerScore += 1
            return
        }
        
        firstPlayerScore += 1
    }
    
    func firstLetter(of name: String) -> String {
        if name.isEmpty {
            return ""
        } else {
            return String(name.dropLast(name.count - 1))
        }
    }
    
    private func compareScores(_ score: Int, with scoreForCompare: Int) -> Color {
        if score > scoreForCompare {
            return .green
        } else if score < scoreForCompare {
            return .red
        } else if score == 0 && scoreForCompare == 0 {
            return .white
        } else {
            return .yellow
        }
    }
    
    func endGame() {
        //
    }
    
    func leave() {
        coordinator.popLast()
    }
    
    func backAction() {
        isBackSheetPresented.toggle()
    }
}
