//
//  GetAPODWorkerDummy.swift
//  APODBox
//
//  Created by Denis Couras on 03/02/25.
//
import XCTest
@testable import APODBox

class GetAPODWorkerDummy: GetAPODWorkerProtocol {
    var result: Result<APODResponseModel, Error>?

    func execute(
        stringDate: String,
        with handle: @escaping (Result<APODResponseModel, Error>) -> Void
    ) {
        if let result = result {
            handle(result)
        }
    }
}
