//
//  RouteService.swift
//  APODBox
//
//  Created by Denis Couras on 30/01/25.
//

public protocol Route: Decodable {
    static var identifier: String { get }
}
