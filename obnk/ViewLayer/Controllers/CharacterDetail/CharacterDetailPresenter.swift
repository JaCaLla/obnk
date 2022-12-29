//
//  CharacterDetailViewPresenter.swift
//  obnk
//
//  Created by Javier Calatrava on 28/12/22.
//

import Foundation
import UIKit

enum CharacterDetailViewSection: CaseIterable {
    case comics
    
    var titleForHeaderInSection: String? {
        switch self {
        case .comics: return "character_detailt_header_title_comic".localized
        }
    }
    
    var section: Int {
        switch self {
        case .comics: return 0
        }
    }
    
    init?(section: Int) {
        guard let type = CharacterDetailViewSection.allCases.first(where: { $0.section == section }) else { return nil }
        self = type
    }
}

protocol CharacterDetailPresenterProtocol{
    func getTitle() -> String
    func getImageURL() -> URL?
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell
    func tableView(_ tableView: UITableView, titleForHeaderInSection section: CharacterDetailViewSection) -> String?
    func getTexts(for userSection: CharacterDetailViewSection) -> [String]
}

final class CharacterDetailPresenter {
    
    private let interactor: CharacterDetailInteractorProtocol
    
    init(interactor: CharacterDetailInteractorProtocol = CharacterDetailInteractor(character: .sample)) {
        self.interactor = interactor
    }
}

// MARK: - CharacterDetailViewPresenter
extension CharacterDetailPresenter: CharacterDetailPresenterProtocol {
    
    func getTitle() -> String {
      return interactor.getCharacter().name
    }
    
    func getImageURL() -> URL? {
        interactor.getCharacter().thumbnail.getURL()
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        var cell = tableView.dequeueReusableCell(withIdentifier: "cellId")
        if cell == nil {
            cell = UITableViewCell(style: UITableViewCell.CellStyle.value1, reuseIdentifier: "cellId")
        }
        guard let cell = cell else { return UITableViewCell() }

        let characterDetailViewSection = CharacterDetailViewSection(section: indexPath.section)
        if characterDetailViewSection == .comics,
           indexPath.row < interactor.getCharacter().comics.count {
            cell.textLabel?.text = interactor.getCharacter().comics[indexPath.row].name
        }
        return cell
    }
    
    func tableView(_ tableView: UITableView, titleForHeaderInSection section: CharacterDetailViewSection) -> String? {
        section.titleForHeaderInSection
    }
    
    func getTexts(for userSection: CharacterDetailViewSection) -> [String] {
        if userSection == .comics {
            return interactor.getCharacter().comics.map({$0.name})
        } else {
            return []
        }
    }
}
