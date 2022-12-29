//
//  CharactersCoordinator.swift
//  obnk
//
//  Created by Javier Calatrava on 28/12/22.
//

import UIKit

final class CharactersCoordinator {
    
    // MARK: - Private attributes
    internal var navigationController = UINavigationController()
    private let characterDetailCoordinator = CharacterDetailCoordinator()
    
    func start(navitagionController: UINavigationController) {
        self.navigationController = navitagionController
        presentCharacterList()
    }
    
    private func presentCharacterList() {
        let interactor = CharactersInteractor()
        let presenter = CharactersPresenter(interactor: interactor)
        let charactersViewController = CharactersViewController.instantiate(presenter: presenter)
        charactersViewController.delegate = self
        navigationController.pushViewController(charactersViewController, animated: true)
    }
}

// MARK: - CharactersViewControllerDelegate
extension CharactersCoordinator: CharactersViewControllerDelegate {
    func showDetail(character: Character) {
        characterDetailCoordinator.start(navitagionController: navigationController,
                                           character: character)
    }
}
