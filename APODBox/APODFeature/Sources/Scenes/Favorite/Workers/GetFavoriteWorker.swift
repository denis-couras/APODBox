//
//  GetFavoriteWorker.swift
//  APODBox
//
//  Created by Denis Couras on 30/01/25.
//

protocol GetFavoriteWorkerProtocol {
func execute() -> [APOD]
}

final class GetFavoriteWorker: GetFavoriteWorkerProtocol {
    func execute() -> [APOD] {
        []
    }
}
