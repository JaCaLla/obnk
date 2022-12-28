//
//  CharactersPresenter.swift
//  obnk
//
//  Created by Javier Calatrava on 28/12/22.
//

import Foundation
import UIKit

protocol CharactersPresenterProtocol {
    func fetch(completion: @escaping (Result<[Character],Error>) -> Void)
//    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int
//    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell
    func hasToRequestFetch(indexPath: IndexPath) -> Bool
    func getCharacters() -> [Character]
}

final class CharactersPresenter {
    
    private let interactor: CharactersInteractorProtocol
    
    init(interactor: CharactersInteractorProtocol = CharactersInteractor()) {
        self.interactor = interactor
    }
}

extension CharactersPresenter: CharactersPresenterProtocol {
    func fetch(completion: @escaping (Result<[Character],Error>) -> Void) {
        interactor.fetch(completion: completion)
    }
    
//    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
//        interactor.getCharacters().count
//    }
//    
//    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
//        guard let charactersListViewCell: CharactersListViewCell = tableView.dequeueReusableCell(withIdentifier: "CharactersListViewCell") as? CharactersListViewCell else { return UITableViewCell() }
//
//        let characters = interactor.getCharacters()
//        let character = characters[indexPath.row]
//        charactersListViewCell.set(character: character)
//
//        return charactersListViewCell
//    }
    
    func hasToRequestFetch(indexPath: IndexPath) -> Bool {
        let characters = interactor.getCharacters()
        
        return indexPath.row >= characters.count - 1
    }
    
    func getCharacters() -> [Character] {
        interactor.getCharacters()
    }
}
