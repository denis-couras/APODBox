//
//  GalleryViewController.swift
//  APODBox
//
//  Created by Denis Couras on 30/01/25.
//
import UIKit

protocol GalleryDisplayLogic: AnyObject {
    func displayError(_ viewModel: GalleryModels.Error.ViewModel)
    func displayAPOD(_ viewModel: GalleryModels.APOD.ViewModel)
    func displayLoading(_ viewModel: GalleryModels.Loading.ViewModel)
    func displayVideoDay(_ viewModel: GalleryModels.MediaDay.ViewModel)
    func displayImageDay(_ viewModel: GalleryModels.MediaDay.ViewModel)
    func displayTagSuccess(_ viewModel: GalleryModels.Tag.ViewModel)
    func displayTagFailure(_ viewModel: GalleryModels.Tag.ViewModel)
    func displayFavorite(_ viewModel: GalleryModels.Favorite.ViewModel)
}

final class GalleryViewController: UIViewController {
    // MARK: - Properties
    private var customView: GalleryViewLogic?
    var interactor: GalleryBusinessLogic
    var router: GalleryRoutingLogic?

    // MARK: - Initialize
    init(interactor: GalleryBusinessLogic) {
        self.interactor = interactor
        super.init(nibName: nil, bundle: nil)
    }

    required init?(coder: NSCoder) {
        fatalError()
    }

    // MARK: - Lifecycle
    override func loadView() {
        view = GalleryView(delegate: self)
        customView = view as? GalleryViewLogic
        view.backgroundColor = .systemBackground
    }

    override func viewDidLoad() {
        super.viewDidLoad()
        interactor.fetchAPOD(.init())
        configureNavigation()
    }

    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)

    }

    private func configureNavigation() {
        navigationItem.title = "Imagem do Dia"
        navigationItem.largeTitleDisplayMode = .always

        navigationItem.rightBarButtonItem = UIBarButtonItem(
                title: "Ação",
                style: .plain,
                target: self,
                action: #selector(selectDateImage)
            )

        navigationItem.rightBarButtonItem?.image = UIImage(systemName: "calendar")
    }

    @objc func selectDateImage() {
        router?.routeToDatePicker(delegate: self)
    }
}

extension GalleryViewController: DataSelectionDelegate {
    func didSelectDate(_ date: String) {
        interactor.fetchAPOD(.init(date: date))
    }
}

extension GalleryViewController: GalleryDisplayLogic {
    func displayLoading(_ viewModel: GalleryModels.Loading.ViewModel) {
        customView?.configureLoading(viewModel)
    }
    
    func displayAPOD(_ viewModel: GalleryModels.APOD.ViewModel) {
        customView?.configureAPOD(viewModel)
    }
    
    func displayVideoDay(_ viewModel: GalleryModels.MediaDay.ViewModel) {
        customView?.configure()
        customView?.configureVideoDay(viewModel)
    }
    
    func displayImageDay(_ viewModel: GalleryModels.MediaDay.ViewModel) {
        customView?.configure()
        customView?.configureImageDay(viewModel)
    }

    func displayError(_ viewModel: GalleryModels.Error.ViewModel) {
        customView?.configureError(viewModel)
    }

    func displayTagSuccess(_ viewModel: GalleryModels.Tag.ViewModel) {
        customView?.configureTag(viewModel)
    }

    func displayTagFailure(_ viewModel: GalleryModels.Tag.ViewModel) {
        customView?.configureTag(viewModel)
    }

    func displayFavorite(_ viewModel: GalleryModels.Favorite.ViewModel) {
        customView?.configureFavorite(viewModel)
    }
}

extension GalleryViewController: GalleryViewDelegate {
    func saveFavorite() {
        interactor.saveFavorite(.init())
    }
}
