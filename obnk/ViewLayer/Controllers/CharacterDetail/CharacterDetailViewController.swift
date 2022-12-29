//
//  CharacterDetailViewController.swift
//  obnk
//
//  Created by Javier Calatrava on 28/12/22.
//

import UIKit

final class CharacterDetailViewController: UIViewController {

    // MARK: - @IBOutlet
    @IBOutlet weak var characterDetailView: CharacterDetailView!

    // MARK: - Private attributes
    private var presenter: CharacterDetailPresenterProtocol = CharacterDetailPresenter()
    
    // MARK: - Constructor/Initializer
    public static func instantiate(presenter: CharacterDetailPresenterProtocol = CharacterDetailPresenter()) -> CharacterDetailViewController {
        let storyboard = UIStoryboard(name: "Characters", bundle: nil)
        guard let characterDetailViewController = storyboard.instantiateViewController(withIdentifier: String(describing: CharacterDetailViewController.self)) as? CharacterDetailViewController else {
            return CharacterDetailViewController()
        }
        characterDetailViewController.presenter = presenter
        return characterDetailViewController
    }

    // MARK: - Lifecycle/Overridden
    override func viewDidLoad() {
        super.viewDidLoad()
        
        setupViewController()
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        characterDetailView.refreshView()
    }
    
    // MARK: - Private methods
    private func setupViewController() {
        self.title = presenter.getTitle()
        characterDetailView.set(presenter: presenter)
    }
}
