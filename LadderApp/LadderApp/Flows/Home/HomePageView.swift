//
//  HomePageView.swift
//  LadderApp
//
//  Created by -_- on 31.01.2023.
//

import SwiftUI

struct HomePageView: View, HomePageViewProtocol {
    var viewModel: StateObject<HomePageViewModel>
    
    init(viewModel: HomePageViewModel) {
        self.viewModel = StateObject(wrappedValue: viewModel)
    }
    
    var body: some View {
        buildIosBody()
    }
}

struct HomePageView_Previews: PreviewProvider {
    static var previews: some View {
        HomePageView(viewModel: .init(coordinator: Coordinator.shared))
    }
}
