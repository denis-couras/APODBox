//
//  FormatDateWorker.swift
//  APODBox
//
//  Created by Denis Couras on 01/02/25.
//

import Foundation

protocol FormatDateWorkerProtocol {
    func execute(stringDate: String?) -> String
}

final class FormatDateWorker: FormatDateWorkerProtocol {
    func execute(stringDate: String?) -> String {
        guard let stringDate = stringDate else {
            return getDefaultDate()
        }
        return stringDate
    }

    private func getDefaultDate() -> String {
        let date = Date()
        let formatter = DateFormatter()
        formatter.dateFormat = "yyyy-MM-dd"
        formatter.timeZone = TimeZone.current

        let dateString = formatter.string(from: date)
        return dateString
    }
}
