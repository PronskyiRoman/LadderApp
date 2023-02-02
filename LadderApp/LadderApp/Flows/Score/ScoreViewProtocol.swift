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
                List(1..<100) { index in
                    buildCell("water.waves.and.arrow.upwater.waves.and.arrow.up", winRate: index, gamesPlayed: 300)
                }
                .listStyle(.grouped)
                .scrollContentBackground(.hidden)
                .background(viewModel.wrappedValue.backgroundColor)
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
            Text("Player")
            Spacer()
            Text("Win Rate")
            Text("Games")
        }
        .padding()
        .frame(height: 44)
    }
}
