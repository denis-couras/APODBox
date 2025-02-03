//
//  APODResponseModel+Fixture.swift
//  APODBox
//
//  Created by Denis Couras on 03/02/25.
//
import XCTest
@testable import APODBox

extension APODResponseModel {
    static func fixture() -> APODResponseModel {
        return .init(
            copyright: "NASA",
            date: "2025-02-03",
            explanation: "Explanation",
            hdurl: "https://example.com/image.jpg",
            mediaType: "image",
            serviceVersion: "v1",
            title: "Title",
            url: "https://example.com/image.jpg"
        )
    }
}
