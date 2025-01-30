//
//  FavoriteConfigurator.swift
//  APODBox
//
//  Created by Denis Couras on 30/01/25.
//
import UIKit

protocol FavoriteAssembly {
    func build(
        route: FavoriteRoute?,
        dependencies: APODFeature
    ) -> UIViewController
}

final class FavoriteAssemble: FavoriteAssembly {
    func build(route: FavoriteRoute?, dependencies: APODFeature) -> UIViewController {
        return FavoriteViewController()
    }
}
