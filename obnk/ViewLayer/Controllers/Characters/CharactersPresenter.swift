//
//  CharactersPresenter.swift
//  obnk
//
//  Created by Javier Calatrava on 28/12/22.
//

import Foundation
import UIKit

// MARK: - Protocol
protocol CharactersPresenterProtocol {
    func fetch(completion: @escaping (Result<[Character],Error>) -> Void)
    func hasToRequestFetch(indexPath: IndexPath) -> Bool
    func getCharacters() -> [Character]
}

// MARK: - CharactersPresenter
final class CharactersPresenter {
    
    // MARK: - Private attributes
    private let interactor: CharactersInteractorProtocol
    
    // MARK: - Constructor/Initializer
    init(interactor: CharactersInteractorProtocol = CharactersInteractor()) {
        self.interactor = interactor
    }
}

// MARK: - CharactersPresenterProtocol
extension CharactersPresenter: CharactersPresenterProtocol {
    
    func fetch(completion: @escaping (Result<[Character],Error>) -> Void) {
        interactor.fetch(completion: completion)
    }
    
    func hasToRequestFetch(indexPath: IndexPath) -> Bool {
        let characters = interactor.getCharacters()
        
        return indexPath.row >= characters.count - 1
    }
    
    func getCharacters() -> [Character] {
        interactor.getCharacters()
    }
}
