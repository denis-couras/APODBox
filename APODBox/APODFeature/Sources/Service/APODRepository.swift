//
//  APODRepository.swift
//  APODBox
//
//  Created by Denis Couras on 30/01/25.
//

protocol APODRepositoryProtocol {
    func getAPOD(date: String, handle: @escaping (Result<APODResponseModel, Error>) -> Void)
}

final class APODRepository: APODRepositoryProtocol {
    private let service: APODServiceProtocol

    init(service: APODServiceProtocol = APODService()) {
        self.service = service
    }

    func getAPOD(date: String, handle: @escaping (Result<APODResponseModel, Error>) -> Void) {
        service.getAPOD(date: date) { result in
            switch result {
            case .success(let model):
                handle(.success(model))
            case .failure(let error):
                handle(.failure(error))
            }
        }
    }
}
