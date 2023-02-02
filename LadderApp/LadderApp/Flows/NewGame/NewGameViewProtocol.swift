//
//  NewGameViewProtocol.swift
//  LadderApp
//
//  Created by -_- on 31.01.2023.
//

import SwiftUI
import CoreData

protocol NewGameViewProtocol {
    associatedtype ViewModel: NewGameViewModelProtocol
    var viewModel: StateObject<ViewModel> { get set }
    
    func buildIosBody(context: NSManagedObjectContext) -> AnyView
}

extension NewGameViewProtocol {
    @ViewBuilder func buildIosBody(context: NSManagedObjectContext) -> AnyView {
        AnyView(buildBody(context: context)
            .sheet(isPresented: viewModel.wrappedValue.isSheetPresentedBinding,
                   onDismiss: viewModel.wrappedValue.checkIsPlayersSelected) {
            SelectPlayersView(viewModel: .init(coordinator: viewModel.wrappedValue.coordinator,
                                               isPresented: viewModel.wrappedValue.isSheetPresentedBinding,
                                               context: context,
                                               firstPlayerName: viewModel.wrappedValue.firstPlayerName,
                                               secondPlayerName: viewModel.wrappedValue.secondPlayerName))}
            .confirmationDialog("", isPresented: viewModel.wrappedValue.isBackSheetPresentedBinding, actions: {
                Button(viewModel.wrappedValue.saveTitle) { viewModel.wrappedValue.endGame(context: context) }
                Button(viewModel.wrappedValue.leaveTitle) { viewModel.wrappedValue.leave() }
            }, message: { Text(viewModel.wrappedValue.errorGameHasNotBeenSaved) }))
    }
    
    @ViewBuilder private func buildBody(context: NSManagedObjectContext) -> some View {
        GeometryReader { view in
            ZStack(alignment: .topLeading) {
                VStack(spacing: .zero) {
                    buildButton(name: viewModel.wrappedValue.firstPlayerNameString, isTop: true, size: view.size)
                    Divider()
                    Spacer(minLength: .zero)
                    
                    HStack {
                        buildTitle()
                        Spacer()
                        buildScore()
                        Spacer()
                        buildEndGameButton(context: context)
                    }
                    .padding(.horizontal)
                    
                    Spacer(minLength: .zero)
                    Divider()
                    buildButton(name: viewModel.wrappedValue.secondPlayerNameString, isTop: false, size: view.size)
                }
                .background(ColorConstants.background)
                
                buildBackButton()
            }
            .toolbar(.hidden, for: .navigationBar)
        }
    }
    
    @ViewBuilder private func buildButton(name: String, isTop: Bool, size: CGSize) -> some View {
        Button {
            viewModel.wrappedValue.updateScore(for: name)
        } label: {
            ZStack {
                viewModel.wrappedValue.playerButtonColor
                    .edgesIgnoringSafeArea(isTop ? .top : .bottom)
                Text(name)
                    .font(viewModel.wrappedValue.playerScoreFont)
                    .foregroundColor(isTop ? viewModel.wrappedValue.firstPlayerForeground : viewModel.wrappedValue.secondPlayerForeground)
            }
            .frame(width: size.width, height: size.height * 0.43)
        }
    }
    
    @ViewBuilder private func buildEndGameButton(context: NSManagedObjectContext) -> some View {
        Button {
            viewModel.wrappedValue.endGame(context: context)
        } label: {
            Text(viewModel.wrappedValue.endGameButtonTitle)
                .foregroundColor(ColorConstants.button)
                .rotationEffect(.degrees(90))
                .font(viewModel.wrappedValue.textFont)
                .padding(5)
        }
    }
    
    @ViewBuilder private func buildScore() -> some View {
        let firstLetterFP = viewModel.wrappedValue.firstLetter(of: viewModel.wrappedValue.firstPlayerNameString)
        let firstLetterSP = viewModel.wrappedValue.firstLetter(of: viewModel.wrappedValue.secondPlayerNameString)
        Group {
            Text(firstLetterFP).font(.title3).foregroundColor(viewModel.wrappedValue.firstPlayerForeground)
            + Text("\(viewModel.wrappedValue.firstPlayerScore)").foregroundColor(viewModel.wrappedValue.firstPlayerForeground)
            + Text(viewModel.wrappedValue.scoreSeparatorTitle)
            + Text(firstLetterSP).font(.title3).foregroundColor(viewModel.wrappedValue.secondPlayerForeground)
            + Text("\(viewModel.wrappedValue.secondPlayerScore)").foregroundColor(viewModel.wrappedValue.secondPlayerForeground)
        }
        .font(viewModel.wrappedValue.playerScoreFont)
    }
    
    @ViewBuilder private func buildTitle() -> some View {
        Text(viewModel.wrappedValue.gameScoreTitile)
            .foregroundColor(ColorConstants.text)
            .rotationEffect(.degrees(-90))
            .font(viewModel.wrappedValue.textFont)
            .padding(5)
    }
    
    @ViewBuilder private func buildBackButton() -> some View {
        Button {
            viewModel.wrappedValue.backAction()
        } label: {
            HStack(spacing: 5) {
                Image(systemName: "chevron.left")
                Text(viewModel.wrappedValue.backTitle)
            }
            .font(viewModel.wrappedValue.textFont)
        }
        .padding()
    }
}
