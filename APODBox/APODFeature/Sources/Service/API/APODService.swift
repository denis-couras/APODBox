//
//  APODService.swift
//  APODBox
//
//  Created by Denis Couras on 30/01/25.
//
import Foundation

protocol APODServiceProtocol {
    func getAPOD(
        date: String,
        handle: @escaping (Result<APODResponseModel, Error>) -> Void
    )
}

final class APODService: APODBoxService<APODServiceAPI>, APODServiceProtocol {
    func getAPOD(
        date: String,
        handle: @escaping (Result<APODResponseModel, Error>) -> Void
    ) {
        fetch(
            target: .getAPOD(date),
            dataType: APODResponseModel.self
        ) { result in
            switch result {
            case .success(let data):
                handle(.success(data))
            case .failure(let error):
                handle(.failure(error))
            }
        }
    }
}

extension URL {
    init<T: Target>(target: T) {
        if target.path.isEmpty {
            self = target.baseURL
        } else {
            self = target.baseURL.appendingPathComponent(target.path)
        }
    }

    init(staticString: String) {
        guard let url = URL(string: staticString) else {
            preconditionFailure("Invalid static URL string: \(staticString)")
        }
        self = url
    }
}
