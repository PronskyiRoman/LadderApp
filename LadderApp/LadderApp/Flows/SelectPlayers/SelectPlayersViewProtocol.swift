//
//  SelectPlayersViewProtocol.swift
//  LadderApp
//
//  Created by -_- on 02.02.2023.
//

import SwiftUI

protocol SelectPlayersViewProtocol {
    associatedtype ViewModel: SelectPlayersViewModelProtocol
    var viewModel: StateObject<ViewModel> { get set }
    
    func buildBody() -> AnyView
}

extension SelectPlayersViewProtocol {
    @ViewBuilder func buildBody() -> AnyView {
        AnyView(whoWillPlayView())
    }
    
    @ViewBuilder private func whoWillPlayView() -> some View {
        ZStack(alignment: .topLeading) {
            viewModel.wrappedValue.backgroundColor
                .ignoresSafeArea()
            VStack {
                Spacer()
                buildTitle()
                Spacer()
                choosePlayerView(viewModel.wrappedValue.isFirstPlayerNew, name: viewModel.wrappedValue.firstPlayerNameBinding, isFirst: true)
                choosePlayerView(viewModel.wrappedValue.isSecondPlayerNew, name: viewModel.wrappedValue.secondPlayerNameBinding, isFirst: false)
                buildStartButton()
                Spacer()
            }
            .frame(maxWidth: .infinity)
            .animation(.default, value: viewModel.wrappedValue.isFirstPlayerNew)
            .animation(.default, value: viewModel.wrappedValue.isSecondPlayerNew)
            
            buildBackButton()
        }
    }
    
    @ViewBuilder private func choosePlayerView(_ isNew: Bool, name: Binding<String>, isFirst: Bool) -> some View {
        HStack(alignment: .top) {
            if isNew {
                VStack(alignment: .leading, spacing: 3) {
                    TextField(viewModel.wrappedValue.enterNewPlayerNamePlaceholder, text: name)
                        .frame(height: 44)
                        .foregroundColor(viewModel.wrappedValue.isChosenPlayerDisabled(isPlayerFirst: isFirst))
                        .padding(.horizontal)
                        .background(viewModel.wrappedValue.textFieldBackgroundColor)
                        .cornerRadius(6)
                    if !viewModel.wrappedValue.firstPlayerErrorMessage.isEmpty || !viewModel.wrappedValue.secondPlayerErrorMessage.isEmpty {
                        Text(isFirst ? viewModel.wrappedValue.firstPlayerErrorMessage : viewModel.wrappedValue.secondPlayerErrorMessage)
                            .foregroundColor(viewModel.wrappedValue.errorTextColor)
                            .font(viewModel.wrappedValue.font)
                            .padding(.leading, 5)
                    }
                }
            } else {
                Menu {
                    ForEach(viewModel.wrappedValue.allPlayers, id: \.self) { player in
                        Button(player) { name.wrappedValue = player }
                            .foregroundColor(viewModel.wrappedValue.titleColor)
                            .disabled(viewModel.wrappedValue.isChosenPlayerDisabled(name: player))
                    }
                } label: {
                    Text(name.wrappedValue.isEmpty ? viewModel.wrappedValue.selectPlayerPlaceholder : name.wrappedValue)
                        .frame(height: 44)
                        .frame(maxWidth: .infinity, alignment: .leading)
                        .padding(.horizontal)
                        .background(viewModel.wrappedValue.textFieldBackgroundColor)
                        .foregroundColor(viewModel.wrappedValue.textColor)
                        .cornerRadius(6)
                }
                .frame(height: 44)
            }
            
            Spacer()
            
            Button {
                viewModel.wrappedValue.playerIsNew(isFirst: isFirst)
            } label: {
                Text(viewModel.wrappedValue.switchButtonTitle(isNew: isNew))
                    .foregroundColor(viewModel.wrappedValue.titleColor)
                    .frame(width: 50)
            }
            .padding()
        }
        .padding(.leading)
    }
    
    @ViewBuilder private func buildTitle() -> some View {
        Text(viewModel.wrappedValue.title)
            .font(viewModel.wrappedValue.titleFont)
            .foregroundColor(viewModel.wrappedValue.titleColor)
            .multilineTextAlignment(.center)
            .padding()
    }
    
    @ViewBuilder private func buildStartButton() -> some View {
        Button {
            viewModel.wrappedValue.startAction()
        } label: {
            Text(viewModel.wrappedValue.startButtonTitle)
                .foregroundColor(viewModel.wrappedValue.startButtonTitleColor())
                .frame(height: 44)
                .frame(maxWidth: .infinity)
        }
        .background(viewModel.wrappedValue.startButtonColor())
        .cornerRadius(5)
        .padding(.horizontal)
        .disabled(viewModel.wrappedValue.isStartDisabled)
        .animation(.default, value: viewModel.wrappedValue.isStartDisabled)
    }
    
    @ViewBuilder private func buildBackButton() -> some View {
        Button(viewModel.wrappedValue.backTitle) {
            viewModel.wrappedValue.backAction()
        }
        .padding(24)
    }
}
