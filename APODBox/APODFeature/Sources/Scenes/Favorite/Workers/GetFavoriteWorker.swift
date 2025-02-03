//
//  GetFavoriteWorker.swift
//  APODBox
//
//  Created by Denis Couras on 30/01/25.
//

protocol GetFavoriteWorkerProtocol {
    func execute() -> [APODResponseModel]
}

final class GetFavoriteWorker: GetFavoriteWorkerProtocol {
    func execute() -> [APODResponseModel] {
        []
    }
}
