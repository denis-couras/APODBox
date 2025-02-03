//
//  APODBoxService.swift
//  APODBox
//
//  Created by Denis Couras on 03/02/25.
//
import Foundation

open class APODBoxService<T: Target> {
    public func fetch<V: Codable>(
        target: T,
        dataType: V.Type,
        completion: @escaping ((Result<V, Error>) -> Void)
    ) {
        let url = createUrl(target)
        debugPrint("[SERVICE] Fetching data from: \(url)")
        let task = URLSession.shared.dataTask(with: url) { data, response, error in
            if let error = error {
                completion(.failure(error))
                return
            }

            guard let data = data else {
                completion(.failure(NSError(domain: "DataError", code: -1, userInfo: nil)))
                return
            }

            do {
                let decoder = JSONDecoder()
                let decodedData = try decoder.decode(V.self, from: data)
                debugPrint("[SERVICE] Response Data: \(decodedData)")
                completion(.success(decodedData))
            } catch {
                completion(.failure(error))
            }
        }
        task.resume()
    }

    private func createUrl<RequestTarget: Target>(_ target: RequestTarget) -> URL {
        let url = URL(target: target)
        let comps = getUrlComponents(task: target.task, url: url)

        guard let compUrl = comps?.url else {
            return url
        }
        return compUrl
    }

    private func getUrlComponents(task: Task, url: URL) -> URLComponents? {
        switch task {
        case .requestParameters(let parameters, _):
            var comps = URLComponents(string: url.absoluteString)
            guard !parameters.isEmpty else { return comps }
            var resultToQueryItems: [URLQueryItem] = []
            resultToQueryItems += parameters.flatMap { queryItems($0.key, $0.value) }
            comps?.queryItems = resultToQueryItems
            return comps
        }
    }

    private func queryItems(_ key: String, _ value: Any) -> [URLQueryItem] {
        var result: [URLQueryItem] = []
        if let array = value as? [AnyObject] {
            result += array.flatMap { queryItems(key, $0) }
        } else {
            result.append(URLQueryItem(name: key, value: "\(value)"))
        }
        return result
    }
}
