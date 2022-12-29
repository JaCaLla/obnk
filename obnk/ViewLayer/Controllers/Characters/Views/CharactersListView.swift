//
//  CharactersListView.swift
//  obnk
//
//  Created by Javier Calatrava on 28/12/22.
//

import UIKit

// MARK: - Protocol
protocol CharactersListViewProtocol: AnyObject {
    func fetch()
    func showDetail(character: Character)
}

// MARK: - CharactersListView
class CharactersListView: UITableView {

    // MARK: - Private attributes
    private var characters: [Character] = []
    private var presenter: CharactersPresenterProtocol = CharactersPresenter()
    private var tableDataSource: UITableViewDiffableDataSource<UITableView.Section, Character>!

    // MARK: - Delegate
    weak var charactersListViewDelegate: CharactersListViewProtocol?

   // MARK: - Lifecycle/Overridden
    override func awakeFromNib() {
        super.awakeFromNib()
        self.setupView()
    }

    // MARK: - Public methods
    func set(characters: [Character]) {
        self.characters = characters
        updateSnapshot()
    }

    func set(presenter: CharactersPresenterProtocol) {
        self.presenter = presenter
    }

    // MARK: - Private/Internal
    private func setupView() {
        setUpTableDataSource()
        self.delegate = self
    }

    private func setUpTableDataSource() {
        tableDataSource = UITableViewDiffableDataSource<UITableView.Section, Character>(tableView: self,
                                                                                        cellProvider: { [weak self] tableView, indexPath, contact in

                                                                                            guard let cell = tableView.dequeueReusableCell(withIdentifier: "CharactersListViewCell") as? CharactersListViewCell else {
                                                                                                return UITableViewCell()
                                                                                            }

                                                                                            if self?.presenter.hasToRequestFetch(indexPath: indexPath) ?? false {
                                                                                                self?.charactersListViewDelegate?.fetch()
                                                                                            }

                                                                                            let character = self?.characters[indexPath.row] ?? .sample
                                                                                            cell.set(character: character)
                                                                                            return cell
                                                                                        })
        updateSnapshot()
    }

    func updateSnapshot(animated: Bool = false) {
        var snapshot = NSDiffableDataSourceSnapshot<UITableView.Section, Character>()
        snapshot.appendSections([.main])
        snapshot.appendItems(characters)
        tableDataSource.apply(snapshot, animatingDifferences: animated)
    }
}

// MARK: - UITableViewDelegate
extension CharactersListView: UITableViewDelegate {

    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        let character = characters[indexPath.row]
        charactersListViewDelegate?.showDetail(character: character)
    }
}

// MARK: - Extension
extension UITableView {
    enum Section {
        case main
    }
}
