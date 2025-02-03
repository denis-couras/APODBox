//
//  FavoriteMedia+Extensions.swift
//  APODBox
//
//  Created by Denis Couras on 03/02/25.
//

extension FavoriteMedia {
    func toResponseModel() -> APODResponseModel {
        .init(
            copyright: self.copyright,
            date: self.date,
            explanation: self.explanation,
            hdurl: self.hdurl,
            mediaType: self.media_type,
            serviceVersion: self.service_version,
            title: self.title,
            url: self.url
        )
    }
}
