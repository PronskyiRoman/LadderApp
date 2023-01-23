//
//  CoreDataManager.swift
//  LadderApp
//
//  Created by -_- on 23.01.2023.
//

import Foundation
import CoreData

final class CoreDataManager: ObservableObject {
    // NSPersistentContainer file name
    private struct Constants {
        static let dataModel = "LadderDataModel"
    }
    
    // private NSPersistentContainer
    private let container = NSPersistentContainer(name: Constants.dataModel)
    
    // init
    private init () {
        container.loadPersistentStores { _, error in
            guard let error else { return }
            debugPrint("Core Data failed to load: \(error.localizedDescription)")
        }
    }
    
    // access to class
    static let shared: CoreDataManager = {
        CoreDataManager.init()
    }()
    
    // current container
    func getContainer() -> NSPersistentContainer {
        container
    }
}
