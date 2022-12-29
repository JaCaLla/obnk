//
//  CharacterDetailViewController.swift
//  obnk
//
//  Created by Javier Calatrava on 28/12/22.
//

import UIKit

class CharacterDetailViewController: UIViewController {

    // MARK: - @IBOutlet
    @IBOutlet weak var characterDetailView: CharacterDetailView!

    var presenter: CharacterDetailPresenterProtocol = CharacterDetailPresenter()
    
    // MARK: - Constructor/Initializer
    public static func instantiate(presenter: CharacterDetailPresenterProtocol = CharacterDetailPresenter()) -> CharacterDetailViewController {
        let storyboard = UIStoryboard(name: "Characters", bundle: nil)
        guard let characterDetailViewController = storyboard.instantiateViewController(withIdentifier: String(describing: CharacterDetailViewController.self)) as? CharacterDetailViewController else {
            return CharacterDetailViewController()
        }
        characterDetailViewController.presenter = presenter
       // presenter.set(routesVC: routesVC)
        return characterDetailViewController
    }

    // MARK: - Lifecycle
    override func viewDidLoad() {
        super.viewDidLoad()
        
        setupViewController()
        // Do any additional setup after loading the view.
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        characterDetailView.refreshView()
    }
    
    
    private func setupViewController() {
        self.title = presenter.getTitle()
        characterDetailView.set(presenter: presenter)
       // self.charactersListView.charactersListViewDelegate = self
    }
}
