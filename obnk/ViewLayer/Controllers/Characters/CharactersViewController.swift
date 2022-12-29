//
//  CharactersViewController.swift
//  obnk
//
//  Created by Javier Calatrava on 28/12/22.
//

import UIKit

protocol CharactersViewControllerDelegate: AnyObject {
    func showDetail(character: Character)
}

protocol CharactersViewControllerProtocol: AnyObject {
    func refreshView()
    func showAlertError()
}

class CharactersViewController: UIViewController {
    
    // MARK: - @IBOutlet
    @IBOutlet weak var charactersListView: CharactersListView!
    @IBOutlet weak var activityIndicator: UIActivityIndicatorView!

    var presenter: CharactersPresenterProtocol = CharactersPresenter()
    weak var delegate: CharactersViewControllerDelegate?
    
    // MARK: - Constructor/Initializer
    public static func instantiate(presenter: CharactersPresenterProtocol = CharactersPresenter()) -> CharactersViewController {
        let storyboard = UIStoryboard(name: "Characters", bundle: nil)
        guard let charactersViewController = storyboard.instantiateViewController(withIdentifier: String(describing: CharactersViewController.self)) as? CharactersViewController else {
            return CharactersViewController()
        }
        charactersViewController.presenter = presenter
        
        return charactersViewController
    }

    // MARK: - Lifecycle
    override func viewDidLoad() {
        super.viewDidLoad()
        
        setupViewController()
        // Do any additional setup after loading the view.
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        refresh()
    }
    
    private func setupViewController() {
        self.title = "characters_title".localized
        self.charactersListView.set(presenter: presenter)
        self.charactersListView.charactersListViewDelegate = self
    }
    
    private func refresh() {
        activityIndicator.isHidden = false
        activityIndicator.startAnimating()
        presenter.fetch { [weak self] result in
            self?.activityIndicator.isHidden = true
            switch result {
            case .success(let characters):
                self?.charactersListView.set(characters: characters)
            case .failure(let error):
                print("todo")
            }
        }
    }
}


// MARK :- CharactersListViewProtocol
extension CharactersViewController: CharactersListViewProtocol {
    func fetch() {
        refresh()
    }
    
    func showDetail(character: Character) {
        guard let delegate = delegate else { return }
        delegate.showDetail(character: character)
    }
}
