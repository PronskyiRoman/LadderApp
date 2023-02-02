//
//  SelectPlayersView.swift
//  LadderApp
//
//  Created by -_- on 02.02.2023.
//

import SwiftUI
import CoreData

struct SelectPlayersView: View, SelectPlayersViewProtocol {
    var viewModel: StateObject<SelectPlayersViewModel>
    
    init(viewModel: SelectPlayersViewModel) {
        self.viewModel = StateObject(wrappedValue: viewModel)
    }
    
    var body: some View {
        buildIosBody()
    }
}

struct SelectPlayers_Previews: PreviewProvider {
    static var previews: some View {
        SelectPlayersView(viewModel: .init(coordinator: Coordinator.shared, isPresented: .constant(false),
                                           context: NSManagedObjectContext.init(concurrencyType: .mainQueueConcurrencyType),
                                           firstPlayerName: .init(initialValue: ""),
                                           secondPlayerName: .init(initialValue: "")))
    }
}
