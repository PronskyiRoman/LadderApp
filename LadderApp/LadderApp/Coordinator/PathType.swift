//
//  PathType.swift
//  LadderApp
//
//  Created by -_- on 26.01.2023.
//

import SwiftUI

protocol PathType: Hashable {
    var destination: AnyView { get }
}
