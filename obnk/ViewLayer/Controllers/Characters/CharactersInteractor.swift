//
//  CharactersInteractor.swift
//  obnk
//
//  Created by Javier Calatrava on 28/12/22.
//

import Foundation
// MARK: - Protocol
protocol CharactersInteractorProtocol {
    func fetch(completion: @escaping (Result<[Character], Error>) -> Void)
    func getCharacters() -> [Character]
}

// MARK: - CharactersInteractor
final class CharactersInteractor {

    // MARK: - Private attribures
    private let dataManager: DataManagerProtocol
    private var fetchedCharacters: [Character] = []

    // MARK: Constructor/Initializer
    init(dataManager: DataManagerProtocol = currentApp.dataManager) {
        self.dataManager = dataManager
    }
}

// MARK: - CharactersInteractorProtocol
extension CharactersInteractor: CharactersInteractorProtocol {
    func fetch(completion: @escaping (Result<[Character], Error>) -> Void) {
        dataManager.fetch { [weak self] result in
            switch result {
            case .success(let characters):
                self?.fetchedCharacters = characters
                completion(.success(characters))
            case .failure(let error):
                completion(.failure(error))
            }
        }
    }

    func getCharacters() -> [Character] {
        return fetchedCharacters
    }
}
