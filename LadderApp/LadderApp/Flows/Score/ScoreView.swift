//
//  ScoreView.swift
//  LadderApp
//
//  Created by -_- on 02.02.2023.
//

import SwiftUI

struct ScoreView: View, ScoreViewProtocol {
    // view Model
    var viewModel: StateObject<ScoreViewModel>
    
    // init
    init(viewModel: ScoreViewModel) {
        self.viewModel = StateObject(wrappedValue: viewModel)
    }
    
    // MARK: Body
    var body: some View {
        buildIosBody()
    }
    
    // MARK: Builders
    @ViewBuilder private func buildIosBody() -> some View {
        buildBody()
    }
}

struct ScoreView_Previews: PreviewProvider {
    static var previews: some View {
        ScoreView(viewModel: .init())
    }
}
