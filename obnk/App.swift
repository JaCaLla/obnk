//
//  App.swift
//  obnk
//
//  Created by Javier Calatrava on 28/12/22.
//

import UIKit

struct App {
    var dataManager: DataManagerProtocol
    
    init(dataManager: DataManagerProtocol = DataManager()) {
        self.dataManager = dataManager
    }
}

let imageCache = NSCache<NSString, UIImage>()
var currentApp = App(dataManager: DataManager())
