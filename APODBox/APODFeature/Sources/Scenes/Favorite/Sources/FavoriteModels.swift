//
//  FavoriteModels.swift
//  APODBox
//
//  Created by Denis Couras on 30/01/25.
//

enum FavoriteModels {

    enum Favorites {
        struct Request {}
        struct Response {
            let model: [FavoriteMedia]
        }
        struct ViewModel {
            let model: FavoriteAPODModel
        }
    }

    struct FavoriteAPODModel {
        var items: [FavoriteItem]
    }

    struct FavoriteItem {
        let title: String
        let date: String
    }

    enum Loading {
        struct Request {}
        struct Response {
            var isActive: Bool
            var message: String = ""
        }
        struct ViewModel {
            var isActive: Bool
            var message: String = ""
        }
    }

    enum EmptyState {
        struct Request {}
        struct Response {}
        struct ViewModel {
            let message: String
        }
    }
}
