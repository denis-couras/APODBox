//
//  GalleryConfigurator.swift
//  APODBox
//
//  Created by Denis Couras on 03/02/25.
//

import UIKit

final class GalleryAssemble {
    static func build(tabController: UITabBarController) -> UIViewController {
        guard let delegate = UIApplication.shared.delegate as? AppDelegate else {
            return UIViewController()
        }

        let coreDataManager: CoreDataManager<FavoriteMedia> = .init(context: delegate.persistentContainer.viewContext)
        let service: APODServiceProtocol = APODService()
        let repository: APODRepositoryProtocol = APODRepository(service: service)
        let repositoryDB: APODRepositoryDB<FavoriteMedia> = APODRepositoryDB<FavoriteMedia>(coreDataManager: coreDataManager)

        let presenter = GalleryPresenter()
        let interactor = GalleryInteractor(
            workers: .init(
                getAPODWorker: GetAPODWorker(repository: repository),
                formatDateWorker: FormatDateWorker(),
                coreDataWorker: CoreDataWorker<FavoriteMedia>(repository: repositoryDB)
            ),
            presenter: presenter
        )
        let view = GalleryViewController(interactor: interactor)
        let router = GalleryRouter()
        router.viewController = view
        router.tabBarController = tabController
        view.router = router
        presenter.viewController = view

        return view
    }
}
