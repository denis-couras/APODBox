//
//  FavoriteViewController.swift
//  APODBox
//
//  Created by Denis Couras on 30/01/25.
//

import UIKit

protocol FavoriteDisplayLogic: AnyObject {
    func displayLoading(_ viewModel: FavoriteModels.Loading.ViewModel)
    func displayFavorites(_ viewModel: FavoriteModels.Favorites.ViewModel)
    func displayEmptyState(_ viewModel: FavoriteModels.EmptyState.ViewModel)
}

final class FavoriteViewController: UIViewController {
    // MARK: - Properties
    private var customView: FavoriteViewLogic?
    var interactor: FavoriteBusinessLogic
    var router: FavoriteRoutingLogic?

    // MARK: - Initialize
    init(interactor: FavoriteBusinessLogic) {
        self.interactor = interactor
        super.init(nibName: nil, bundle: nil)
    }

    required init?(coder: NSCoder) {
        fatalError()
    }

    // MARK: - Lifecycle
    override func loadView() {
        view = FavoriteView(delegate: self)
        customView = view as? FavoriteViewLogic
        view.backgroundColor = .systemBackground
    }

    override func viewDidLoad() {
        super.viewDidLoad()
        configureNavigation(title: "Favoritos")
    }

    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        interactor.fechFavorites()
    }

    private func configureNavigation(title: String) {
        DispatchQueue.main.async {
            self.navigationItem.title = title
            self.navigationItem.largeTitleDisplayMode = .always
        }
    }
}

extension FavoriteViewController: FavoriteDisplayLogic {
    func displayLoading(_ viewModel: FavoriteModels.Loading.ViewModel) {
        customView?.configureLoading(viewModel)
    }

    func displayEmptyState(_ viewModel: FavoriteModels.EmptyState.ViewModel) {
        customView?.configureEmptyState(viewModel)
    }

    func displayFavorites(_ viewModel: FavoriteModels.Favorites.ViewModel) {
        customView?.configureFavorites(viewModel)
    }
}

extension FavoriteViewController: FavoriteViewDelegate {
    func showFavoriteDetails(favorite: FavoriteModels.FavoriteItem) {
        router?.navigateToGallery(index: 0, favorite: favorite)
    }
}
