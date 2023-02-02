//
//  NewGameView.swift
//  LadderApp
//
//  Created by -_- on 31.01.2023.
//

import SwiftUI
import CoreData

struct NewGameView: View, NewGameViewProtocol {
    // view Model
    var viewModel: StateObject<NewGameViewModel>
    
    // context
    @Environment(\.managedObjectContext) var context
    
    // init
    init(viewModel: NewGameViewModel) {
        self.viewModel = StateObject(wrappedValue: viewModel)
    }
    
    // MARK: Body
    var body: some View {
        buildIosBody(context: context)
    }
    
    // MARK: Builders
    @ViewBuilder private func buildIosBody(context: NSManagedObjectContext) -> some View {
        buildBody(context: context)
    }
}

struct NewGameView_Previews: PreviewProvider {
    static var previews: some View {
        NewGameView(viewModel: .init(coordinator: Coordinator.shared))
    }
}
