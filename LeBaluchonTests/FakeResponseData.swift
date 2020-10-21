//
//  FakeResponseData.swift
//  LeBaluchonTests
//
//  Created by ousama boujaouane on 21/10/2020.
//  Copyright © 2020 Sajid. All rights reserved.
//

import Foundation

class FakeResponseData {
    // MARK: - HTTP status code
    let responseOK = HTTPURLResponse(
        url: URL(string: "https://openclassrooms.com")!,
        statusCode: 200,
        httpVersion: nil,
        headerFields: nil)!

    let responseKO = HTTPURLResponse(
        url: URL(string: "https://openclassrooms.com")!,
        statusCode: 500,
        httpVersion: nil,
        headerFields: nil)!

    // MARK: - Error
    class SimpleError: Error {}
    let error = SimpleError()

    // MARK: - Incorrect data
    let incorrectData = "erreur".data(using: .utf8)!

    // MARK: - Fixer
    // TODO

    // MARK: - Google Translate
    var translateCorrectData: Data {
        let bundle = Bundle(for: FakeResponseData.self)
        let url = bundle.url(forResource: "googleTranslate", withExtension: "json")
        // swiftlint:disable force_try
        let data = try! Data(contentsOf: url!)
        return data
    }

    // MARK: - Yahoo Weather
    // TODO
}
