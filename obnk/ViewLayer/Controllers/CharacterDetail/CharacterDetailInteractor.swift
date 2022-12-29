//
//  CharacterDetailViewInteractor.swift
//  obnk
//
//  Created by Javier Calatrava on 28/12/22.
//

import Foundation

protocol CharacterDetailInteractorProtocol {
    func getCharacter() -> Character
}

final class CharacterDetailInteractor {
    
    private let character: Character
    
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
