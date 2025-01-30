//
//  APODModel.swift
//  APODBox
//
//  Created by Denis Couras on 30/01/25.
//

struct APOD: Codable {
    let title: String
    let explanation: String
    let url: String
    let mediaType: String?

    enum CodingKeys: String, CodingKey {
        case title, explanation, url
        case mediaType = "media_type"
    }
}
