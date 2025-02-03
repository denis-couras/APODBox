//
//  GetAPODWorker.swift
//  APODBox
//
//  Created by Denis Couras on 01/02/25.
//

import Foundation

protocol GetAPODWorkerProtocol {
    func execute(
        stringDate: String,
        with handle: @escaping (Result<APODResponseModel, Error>) -> Void
    )
}

final class GetAPODWorker: GetAPODWorkerProtocol {
    // MARK: - Properties
    private let repository: APODRepositoryProtocol

    init(repository: APODRepositoryProtocol) {
        self.repository = repository
    }
    
    func execute(
        stringDate: String,
        with handle: @escaping (Result<APODResponseModel, any Error>) -> Void
    ) {
        repository.getAPOD(date: stringDate) { result in
            switch result {
            case .success(let model):
                handle(.success(model))
            case .failure(let error):
                handle(.failure(error))
            }
        }
    }
}
