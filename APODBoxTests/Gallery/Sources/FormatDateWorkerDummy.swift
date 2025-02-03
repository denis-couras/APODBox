//
//  FormatDateWorkerDummy.swift
//  APODBox
//
//  Created by Denis Couras on 03/02/25.
//
import XCTest
@testable import APODBox

class FormatDateWorkerDummy: FormatDateWorkerProtocol {
    func execute(stringDate: String?) -> String {
        return stringDate ?? ""
    }
}
