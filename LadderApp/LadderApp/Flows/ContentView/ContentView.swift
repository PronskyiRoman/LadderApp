//
//  ContentView.swift
//  LadderApp
//
//  Created by -_- on 23.01.2023.
//

import SwiftUI

struct ContentView<Model>: View, ContentViewProtocol where Model: AnyCoordinatable {
    // view Model
    var viewModel: StateObject<ContentViewModel>
    
    // Content coordinator
    @StateObject var coordinator: Model
    
    // context
    @Environment(\.managedObjectContext) var context
    
    // init
    init(viewModel: ContentViewModel, coordinator: Model) {
        self.viewModel = StateObject.init(wrappedValue: viewModel)
        _coordinator = StateObject.init(wrappedValue: coordinator)
    }
    
    // MARK: Body
    var body: some View {
        buildBody()
    }
    
    // MARK: Builders
    @ViewBuilder func buildBody() -> some View {
        NavigationStack(path: $coordinator.path) {
            AnyView(buildIosBody())
                .navigationDestination(for: Model.CoordinatorPath.self) { path in
                    path.destination
                }
        }
    }
    
    @ViewBuilder func buildIosBody() -> any View {
        HomePageView(viewModel: .init(coordinator: viewModel.wrappedValue.coordinator))
    }
}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView(viewModel: .init(), coordinator: Coordinator.shared)
    }
}
