//
//  HomePageViewProtocol.swift
//  LadderApp
//
//  Created by -_- on 31.01.2023.
//

import SwiftUI

protocol HomePageViewProtocol {
    associatedtype ViewModel: HomePageViewModelProtocol
    var viewModel: StateObject<ViewModel> { get set }
    
    func buildIosBody() -> AnyView
}

extension HomePageViewProtocol {
    @ViewBuilder func buildIosBody() -> AnyView {
        AnyView(ZStack {
            buildBackground()
                .navigationTitle(viewModel.wrappedValue.navTitle)
                .navigationBarTitleDisplayMode(.inline)
            VStack {
                buildButton(viewModel.wrappedValue.playTitle, action: { viewModel.wrappedValue.pushNewGame() })
                buildButton(viewModel.wrappedValue.viewScoreTitle, action: { viewModel.wrappedValue.pushScoreTable() })
            }})
    }
    
    @ViewBuilder private func buildButton(_ text: String, action: @escaping () -> Void) -> some View {
        Button {
            action()
        } label: {
            Text(text)
                .font(viewModel.wrappedValue.buttonFont)
                .foregroundColor(viewModel.wrappedValue.buttonColor)
                .padding()
        }
        .padding()
    }
    
    @ViewBuilder private func buildBackground() -> some View {
        viewModel.wrappedValue.backgroundColor
            .ignoresSafeArea()
    }
}
