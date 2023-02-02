//
//  NewGameView.swift
//  LadderApp
//
//  Created by -_- on 31.01.2023.
//

import SwiftUI

struct NewGameView: View, NewGameViewProtocol {
    var viewModel: StateObject<NewGameViewModel>
    @Environment(\.managedObjectContext) var context
    
    init(viewModel: NewGameViewModel) {
        self.viewModel = StateObject(wrappedValue: viewModel)
    }
    
    var body: some View {
        buildIosBody(context: context)
    }
}

struct NewGameView_Previews: PreviewProvider {
    static var previews: some View {
        NewGameView(viewModel: .init(coordinator: Coordinator.shared))
    }
}
