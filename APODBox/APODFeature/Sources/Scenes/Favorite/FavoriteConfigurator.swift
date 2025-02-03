//
//  FavoriteConfigurator.swift
//  APODBox
//
//  Created by Denis Couras on 30/01/25.
//
import UIKit

final class FavoriteAssemble {
    static func build(tabController: UITabBarController) -> UIViewController {
        guard let delegate = UIApplication.shared.delegate as? AppDelegate else {
            return UIViewController()
        }

        let coreDataManager: CoreDataManager<FavoriteMedia> = .init(context: delegate.persistentContainer.viewContext)
        let repositoryDB = APODRepositoryDB<FavoriteMedia>(coreDataManager: coreDataManager)

        let presenter = FavoritePresenter()
        let interactor = FavoriteInteractor(
            workers: .init(
                coreDataWorker: CoreDataWorker<FavoriteMedia>(repository: repositoryDB)),
            presenter: presenter
        )
        let view = FavoriteViewController(interactor: interactor)
        let router = FavoriteRouter()
        router.viewController = view
        router.tabBarController = tabController
        presenter.viewController = view
        view.router = router
        return view
    }
}
