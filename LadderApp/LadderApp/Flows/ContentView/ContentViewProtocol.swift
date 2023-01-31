//
//  ContentViewProtocol.swift
//  LadderApp
//
//  Created by -_- on 26.01.2023.
//

import SwiftUI

protocol ContentViewProtocol {
    associatedtype ViewModel: ContentViewModelProtocol
    var viewModel: StateObject<ViewModel> { get set }
    
    func buildIosBody() -> any View
}

protocol ContentViewModelProtocol: ObservableObject {
    associatedtype Model: AnyCoordinatable
    var coordinator: Model { get set }
}
