//
//  TabBarController.swift
//  APODBox
//
//  Created by Denis Couras on 30/01/25.
//

import UIKit

class TabBarController: UITabBarController {
    override func viewDidLoad() {
        super.viewDidLoad()
    }

    override func viewWillAppear(_ animated: Bool) {
        view.backgroundColor = .white

        let galleryVC = GalleryAssemble.build(tabController: self)
        let favoriteVC = FavoriteAssemble.build(tabController: self)

        galleryVC.tabBarItem = UITabBarItem(title: "Mídia do Dia", image: UIImage(systemName: "photo.fill"), tag: 0)
        favoriteVC.tabBarItem = UITabBarItem(title: "Favoritos", image: UIImage(systemName: "star.fill"), tag: 1)

        viewControllers = [
            UINavigationController(rootViewController: galleryVC),
            UINavigationController(rootViewController: favoriteVC)
        ]
    }
}

