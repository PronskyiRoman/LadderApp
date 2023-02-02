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
        AnyView(Color.red)
    }
}
