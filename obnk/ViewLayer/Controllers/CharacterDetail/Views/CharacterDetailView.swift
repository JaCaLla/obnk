//
//  CharacterDetailView.swift
//  obnk
//
//  Created by Javier Calatrava on 28/12/22.
//

import UIKit

final class CharacterDetailView: UITableView {

    // MARK: - Private attributes
    private var presenter: CharacterDetailPresenterProtocol = CharacterDetailPresenter()
    private var tableDataSource: UserTableViewDiffibleDataSource!

    // MARK: - Delegate
    weak var charactersListViewDelegate: CharactersListViewProtocol?

    // MARK: - Lifecycle/Overridden
    override func awakeFromNib() {
        super.awakeFromNib()
        self.setupView()
    }

    // MARK: - Public helpers
    func set(presenter: CharacterDetailPresenterProtocol) {
        self.presenter = presenter
        refreshView()
    }

    func refreshView() {
        let imageHeader = UIImageView(frame: CGRect(x: 0, y: 0, width: frame.width, height: frame.width))
        if let url = presenter.getImageURL() {
            imageHeader.setImage(from: url)
            imageHeader.contentMode = .scaleAspectFit
        }
        let header = UIView(frame: imageHeader.frame)
        header.addSubview(imageHeader)
        self.tableHeaderView = header
    }

    // MARK: - Private/Internal
    private func setupView() {
        setUpTableDataSource()
    }

    private func setUpTableDataSource() {
        tableDataSource = UserTableViewDiffibleDataSource(tableView: self,
                                                          cellProvider: { [weak self] tableView, indexPath, contact in
                                                              return self?.presenter.tableView(tableView, cellForRowAt: indexPath)
                                                          })
        updateSnapshot()
    }

    private func updateSnapshot(animated: Bool = false) {
        var snapshot = NSDiffableDataSourceSnapshot<CharacterDetailViewSection, String>()
        snapshot.appendSections(CharacterDetailViewSection.allCases)
        let comics = presenter.getTexts(for: .comics)
        snapshot.appendItems(comics, toSection: .comics)
        tableDataSource.apply(snapshot, animatingDifferences: animated)
    }
}

class UserTableViewDiffibleDataSource: UITableViewDiffableDataSource<CharacterDetailViewSection, String> {

    private var presenter: CharacterDetailPresenterProtocol = CharacterDetailPresenter()

    func set(presenter: CharacterDetailPresenterProtocol) {
        self.presenter = presenter
    }

    override func tableView(_ tableView: UITableView, titleForHeaderInSection section: Int) -> String? {
        guard let section = CharacterDetailViewSection(section: section) else { return nil }
        return presenter.tableView(tableView, titleForHeaderInSection: section)
    }
}
