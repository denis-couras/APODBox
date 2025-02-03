//
//  FavoriteRouter.swift
//  APODBox
//
//  Created by Denis Couras on 30/01/25.
//
import UIKit

protocol FavoriteRoutingLogic {
    func navigateToGallery(index: Int, favorite: FavoriteModels.FavoriteItem)
}

final class FavoriteRouter: FavoriteRoutingLogic {
    weak var viewController: FavoriteViewController?
    weak var tabBarController: UITabBarController?

    func navigateToGallery(index: Int, favorite: FavoriteModels.FavoriteItem) {
        guard let tabBarController = tabBarController,
              let viewControllers = tabBarController.viewControllers,
              index < viewControllers.count,
              let targetNavController = viewControllers[index] as? UINavigationController,
              let targetViewController = targetNavController.topViewController as? GalleryViewController else {
            return
        }

        targetViewController.interactor.fetchAPOD(.init(date: favorite.date))
        tabBarController.selectedIndex = index
    }
}
