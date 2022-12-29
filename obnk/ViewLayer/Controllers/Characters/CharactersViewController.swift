//
//  CharactersViewController.swift
//  obnk
//
//  Created by Javier Calatrava on 28/12/22.
//

import UIKit

// MARK: - Protocols
protocol CharactersViewControllerDelegate: AnyObject {
    func showDetail(character: Character)
}

protocol CharactersViewControllerProtocol: AnyObject {
    func refreshView()
    func showAlertError()
}

// MARK: - CharactersViewController
class CharactersViewController: UIViewController {
    
    // MARK: - @IBOutlet
    @IBOutlet weak var charactersListView: CharactersListView!
    @IBOutlet weak var activityIndicator: UIActivityIndicatorView!

    // MARK: - Private attributes
    private var presenter: CharactersPresenterProtocol = CharactersPresenter()
    
    // MARK: - Delegate
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

    // MARK: - Lifecycle/Overridden
    override func viewDidLoad() {
        super.viewDidLoad()
        
        setupViewController()
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        refresh()
    }
    
    // MARK: -  Private attributes
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
                self?.presentAlert(error: error)
            }
        }
    }
    
    private func presentAlert(error: Error) {
        let alert = UIAlertController(title: "characters_alert_title".localized,
                                      message: error.localizedDescription,
                                      preferredStyle: UIAlertController.Style.alert)
        alert.addAction(UIAlertAction(title: "Retry", style: .cancel, handler: { [weak self] _ in
            self?.refresh()
             }))
        self.present(alert, animated: true, completion: nil)
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
