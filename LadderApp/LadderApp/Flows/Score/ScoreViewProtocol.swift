//
//  ScoreViewProtocol.swift
//  LadderApp
//
//  Created by -_- on 02.02.2023.
//

import SwiftUI

protocol ScoreViewProtocol {
    associatedtype ViewModel: ScoreViewModelProtocol
    var viewModel: StateObject<ViewModel> { get set }
    
    func buildBody() -> AnyView
}

extension ScoreViewProtocol {
    func buildBody() -> AnyView {
        AnyView(ZStack {
            viewModel.wrappedValue.headerBackgroundColor
                .ignoresSafeArea()
            VStack(spacing: .zero) {
                buildHeader()
                if !viewModel.wrappedValue.players.isEmpty {
                    List(viewModel.wrappedValue.players.sorted(by: { $0.gamesPlayed > $1.gamesPlayed })) { player in
                        buildCell(player.name, winRate: player.winRate, gamesPlayed: player.gamesPlayed)
                    }
                    .listStyle(.grouped)
                    .scrollContentBackground(.hidden)
                    .background(viewModel.wrappedValue.backgroundColor)
                } else {
                    buildEmptyView()
                }
            }
            .navigationBarTitle(viewModel.wrappedValue.navigationTitle)
            .edgesIgnoringSafeArea(.bottom)
        })
    }
    
    @ViewBuilder private func buildCell(_ name: String, winRate: Int, gamesPlayed: Int) -> some View {
        HStack(alignment: .center, spacing: .zero) {
            buildPlayrNameLabel(name)
            Spacer()
            buildWinRateLabel(winRate)
            buildPlayedLabel(gamesPlayed)
        }
        .padding(10)
        .listRowInsets(EdgeInsets())
        .background(viewModel.wrappedValue.backgroundColor)
    }
    
    @ViewBuilder private func buildWinRateLabel(_ winRate: Int) -> some View {
        HStack(spacing: .zero) {
            Text("\(winRate)").font(viewModel.wrappedValue.fontText)
            + Text("%").font(viewModel.wrappedValue.fontDescription)
            viewModel.wrappedValue.imageFor(rate: winRate)
        }
        .foregroundColor(viewModel.wrappedValue.winRateForeground(rate: winRate))
        .padding(.horizontal, 5)
    }
    
    @ViewBuilder private func buildPlayedLabel(_ games: Int) -> some View {
        Text("\(games)")
            .padding()
            .font(viewModel.wrappedValue.fontDescription)
            .foregroundColor(viewModel.wrappedValue.textColor)
    }
    
    @ViewBuilder private func buildPlayrNameLabel(_ name: String) -> some View {
        Text(name)
            .lineLimit(1)
            .foregroundColor(viewModel.wrappedValue.textColor)
    }
    
    @ViewBuilder private func buildHeader() -> some View {
        HStack {
            Text(viewModel.wrappedValue.playerSectionHeader)
            Spacer()
            Text(viewModel.wrappedValue.winRateSectionHeader)
            Text(viewModel.wrappedValue.gamesSectionHeader)
        }
        .padding()
        .frame(height: 44)
    }
    
    @ViewBuilder private func buildEmptyView() -> some View {
        VStack {
            Spacer()
            Text(viewModel.wrappedValue.emptyViewTitle)
                .multilineTextAlignment(.center)
                .font(viewModel.wrappedValue.fontText)
                .foregroundColor(viewModel.wrappedValue.textColor)
            Spacer()
        }
        .frame(maxWidth: .infinity, maxHeight: .infinity)
        .background(viewModel.wrappedValue.backgroundColor)
    }
}
