//
//  GalleryModels.swift
//  APODBox
//
//  Created by Denis Couras on 30/01/25.
//
import Foundation

enum GalleryModels {
    enum GalleryState {
        case loading(Loading.Response)
        case configure(APODModel)
    }

    enum GetMediaDay {
        struct Request {
            var date: String?
        }
        struct Response {}
        struct ViewModel {}
    }

    enum APOD {
        struct Request {}
        struct Response {
            let model: APODResponseModel
        }
        struct ViewModel {
            let title: String
            let explanation: String
            let copyright: String
            let date: String
        }
    }

    enum MediaDay {
        struct Request {}
        struct Response {}
        struct ViewModel {
            let url: URL
        }
    }

    enum Media {
        struct Request {}
        typealias Response = MediaType
        struct ViewModel {}
    }

    enum MediaType {
        case image(URL)
        case video(URL)
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

    enum Error {
        struct Request {}
        struct Response {}
        struct ViewModel {}
    }

    struct APODModel {
        let title: String
        let explanation: String
    }

    enum TagType {
        case success
        case successRemove
        case failure
        case failureRemove
    }

    enum Tag {
        struct Request {}
        typealias Response = TagType
        struct ViewModel {
            let message: String
            let type: TagType
        }
    }

    enum Favorite {
        struct Request {}
        struct Response {
            let isFavorite: Bool
        }
        struct ViewModel {
            let isFavorite: Bool
        }
    }
}
