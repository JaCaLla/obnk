//
//  CharacterDetailViewInteractor.swift
//  obnk
//
//  Created by Javier Calatrava on 28/12/22.
//

import Foundation

// MARK: - Protocol
protocol CharacterDetailInteractorProtocol {
    func getCharacter() -> Character
}

// MARK: - CharacterDetailInteractor
final class CharacterDetailInteractor {
    
    // MARK: - Private attributes
    private let character: Character
    
    // MARK: - CharacterDetailViewPresenter
    init(character: Character) {
        self.character = character
    }
}

// MARK: - CharacterDetailViewInteractorProtocol
extension CharacterDetailInteractor: CharacterDetailInteractorProtocol {
    func getCharacter() -> Character {
        character
    }
}
