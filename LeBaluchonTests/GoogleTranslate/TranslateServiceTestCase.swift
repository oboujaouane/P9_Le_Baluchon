//
//  TranslateServiceTestCase.swift
//  LeBaluchonTests
//
//  Created by ousama boujaouane on 21/10/2020.
//  Copyright © 2020 Sajid. All rights reserved.
//

@testable import LeBaluchon
import XCTest

class TranslateServiceTestCase: XCTestCase {

    func testGetTranslationShouldPostFailedCallbackIfError() {
        // Given
        let translateService = TranslateService(translateSession: URLSessionFake(data: nil,
                                                                                 response: nil,
                                                                                 error: FakeResponseData.error)
        )

        // When
        let expectation = XCTestExpectation(description: "Wait for queue change.")
        translateService.getTranslation(with: "error") { success, translatedText in
            //Then
            XCTAssertFalse(success)
            XCTAssertNil(translatedText)
            expectation.fulfill()
        }

        wait(for: [expectation], timeout: 0.01)
    }

    func testGetTranslationShouldPostFailedCallbackIfNoData() {
        // Given
        let translateService = TranslateService(translateSession: URLSessionFake(data: nil,
                                                                                 response: nil,
                                                                                 error: nil)
        )

        // When
        let expectation = XCTestExpectation(description: "Wait for queue change.")
        translateService.getTranslation(with: "error") { success, translatedText in
            //Then
            XCTAssertFalse(success)
            XCTAssertNil(translatedText)
            expectation.fulfill()
        }

        wait(for: [expectation], timeout: 0.01)
    }

    func testGetTranslationShouldPostFailedCallbackIfIncorrectResponse() {
        // Given
        let translateService = TranslateService(translateSession: URLSessionFake(
            data: FakeResponseData.translateCorrectData,
            response: FakeResponseData.responseKO,
            error: nil)
        )

        // When
        let expectation = XCTestExpectation(description: "Wait for queue change.")
        translateService.getTranslation(with: "error") { success, translatedText in
            //Then
            XCTAssertFalse(success)
            XCTAssertNil(translatedText)
            expectation.fulfill()
        }

        wait(for: [expectation], timeout: 0.01)
    }

    func testGetTranslationShouldPostFailedCallbackIfIncorrectData() {
          // Given
          let translateService = TranslateService(translateSession: URLSessionFake(
            data: FakeResponseData.incorrectData,
            response: FakeResponseData.responseOK,
            error: nil)
          )

          // When
          let expectation = XCTestExpectation(description: "Wait for queue change.")
          translateService.getTranslation(with: "error") { success, translatedText in
              //Then
              XCTAssertFalse(success)
              XCTAssertNil(translatedText)
              expectation.fulfill()
          }

          wait(for: [expectation], timeout: 0.01)
      }

    func testGetTranslationShouldPostSuccessCallbackIfNoErrorAndCorrectData() {
        // Given
        let translateService = TranslateService(translateSession: URLSessionFake(
            data: FakeResponseData.translateCorrectData,
            response: FakeResponseData.responseOK,
            error: nil)
        )

        // When
        let expectation = XCTestExpectation(description: "Wait for queue change.")
        translateService.getTranslation(with: "error") { success, translatedText in
            //Then
            let text = "Hello how are you?"

            XCTAssertTrue(success)
            XCTAssertNotNil(translatedText)
            XCTAssertEqual(text, translatedText)
            expectation.fulfill()
        }

        wait(for: [expectation], timeout: 0.01)
    }

}
