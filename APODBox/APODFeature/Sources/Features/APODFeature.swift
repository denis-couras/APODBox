//
//  APODFeature.swift
//  APODBox
//
//  Created by Denis Couras on 30/01/25.
//

import UIKit

public struct APODFeature {

    // MARK: Properties
    private let favoriteAssembly: FavoriteAssembly

    init(favoriteAssembly: FavoriteAssembly) {
        self.favoriteAssembly = favoriteAssembly
    }

    func build(fromRoute route: Route?) -> UIViewController {
        switch route {
        case let route as FavoriteRoute:
            let viewController = favoriteAssembly.build(route: route, dependencies: self)
            return UINavigationController(rootViewController: viewController)
        default:
            break
        }
        return UIViewController()
    }
}
