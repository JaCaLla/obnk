//
//  MainFlowCoordinator.swift
//  obnk
//
//  Created by Javier Calatrava on 28/12/22.
//

import Foundation
import UIKit


class MainFlowCoordinator {
    
    // MARK: - Singleton handler
    static let shared = MainFlowCoordinator()
    
    // MARK: - Private attributes
    private let navigationController =  UINavigationController()
    private let charactersCoordinator = CharactersCoordinator()
    
    
    private init() { /*This prevents others from using the default '()' initializer for this class. */ }
    
    // MARK: - Pulic methods
    func start() {
        presentHome()
    }
    
    // MARK: - Private/Internal
    private func presentHome() {
        
        charactersCoordinator.start(navitagionController: navigationController)
        
        if let window = UIApplication.shared.keyWindow {
            window.rootViewController  = navigationController
        }
    }
}
