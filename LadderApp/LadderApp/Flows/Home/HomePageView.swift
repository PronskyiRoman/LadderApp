//
//  HomePageView.swift
//  LadderApp
//
//  Created by -_- on 31.01.2023.
//

import SwiftUI

struct HomePageView: View, HomePageViewProtocol {
    // view Model
    var viewModel: StateObject<HomePageViewModel>
    
    // init
    init(viewModel: HomePageViewModel) {
        self.viewModel = StateObject(wrappedValue: viewModel)
    }
    
    // MARK: Body
    var body: some View {
        buildIosBody()
    }
    
    // MARK: Builders
}

struct HomePageView_Previews: PreviewProvider {
    static var previews: some View {
        HomePageView(viewModel: .init(coordinator: Coordinator.shared))
    }
}
