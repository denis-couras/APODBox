//
//  APODServiceAPI.swift
//  APODBox
//
//  Created by Denis Couras on 30/01/25.
//

import Foundation

enum APODServiceAPI {
    case getAPOD(String)
}

extension APODServiceAPI: Target {
    var baseURL: URL {
        let baseUrl = Bundle.main.infoDictionary?["APOD_url"] as? String ?? ""
        return URL(staticString: baseUrl)
    }

    var apiKey: String {
        return Bundle.main.object(forInfoDictionaryKey: "APOD_key") as? String ?? ""
    }

    var path: String {
        switch self {
        case .getAPOD:
            return "/apod"
        }
    }
    
    var method: HTTPMethod {
        switch self {
        case .getAPOD:
            return .get
        }
    }

    var task: Task {
        switch self {
        case .getAPOD(let date):
            return .requestParameters(
                [
                    "api_key": apiKey,
                    "date": date
                ],
                encoding: .queryString
            )
        }
    }
}

public enum HTTPMethod: String {
    case get = "GET"
    case post = "POST"
    case update = "PUT"
    case delete = "DELETE"
}

public enum ParameterEncoding {
    case queryString
    case httpBody
}

public enum Task {
    case requestParameters(_ parameters: [String: Any], encoding: ParameterEncoding)
}

public protocol Target {
    var path: String { get }
    var method: HTTPMethod { get }
    var baseURL: URL { get }
    var task: Task { get }
}
