//
//  App.swift
//  obnk
//
//  Created by Javier Calatrava on 28/12/22.
//

import Foundation

struct App {
    var dataManager: DataManagerProtocol
    
    init(dataManager: DataManagerProtocol = DataManager()) {
        self.dataManager = dataManager
    }
}

var currentApp = App(dataManager: DataManager())
