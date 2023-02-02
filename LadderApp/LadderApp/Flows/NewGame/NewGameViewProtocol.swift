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
        AnyView(buildBody()
            .sheet(isPresented: viewModel.wrappedValue.isSheetPresentedBinding,
                   onDismiss: viewModel.wrappedValue.checkIsPlayersSelected) {
            SelectPlayersView(viewModel: .init(coordinator: viewModel.wrappedValue.coordinator,
                                               isPresented: viewModel.wrappedValue.isSheetPresentedBinding,
                                               context: context,
                                               firstPlayerName: viewModel.wrappedValue.firstPlayerName,
                                               secondPlayerName: viewModel.wrappedValue.secondPlayerName))
            })
    }
    
    @ViewBuilder private func buildBody() -> some View {
        VStack {
            Text(viewModel.wrappedValue.firstPlayerNameString)
            Text(viewModel.wrappedValue.secondPlayerNameString)
        }
        .font(.title)
    }
}
