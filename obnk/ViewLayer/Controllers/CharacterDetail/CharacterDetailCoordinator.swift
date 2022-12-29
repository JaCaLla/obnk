//
//  CharacterDetailCoordinator.swift
//  obnk
//
//  Created by Javier Calatrava on 28/12/22.
//
import UIKit

final class CharacterDetailCoordinator {
    
    // MARK: - Private attributes
     internal var navigationController = UINavigationController()

    // MARK: - Public helpers
    func start(navitagionController: UINavigationController, character: Character) {
        self.navigationController = navitagionController
        presentCharacterDetail(character: character)
    }
    
    // MARK: - Private methods
    private func presentCharacterDetail(character: Character) {
        let interactor = CharacterDetailInteractor(character: character)
        let presenter = CharacterDetailPresenter(interactor: interactor)
        let charactersViewController = CharacterDetailViewController.instantiate(presenter: presenter)
        navigationController.pushViewController(charactersViewController, animated: true)
    }
}

