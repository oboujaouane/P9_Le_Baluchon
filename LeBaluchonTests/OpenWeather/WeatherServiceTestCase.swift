//
//  WeatherServiceTestCase.swift
//  LeBaluchonTests
//
//  Created by ousama boujaouane on 21/10/2020.
//  Copyright © 2020 Sajid. All rights reserved.
//

@testable import LeBaluchon
import XCTest

class WeatherServiceTestCase: XCTestCase {

    func testGetWeatherShouldPostFailedCallbackIfError() {
        // Given
        let weatherService = WeatherService(weatherSession: URLSessionFake(data: nil,
                                                                           response: nil,
                                                                           error: FakeResponseData.error)
        )

        // When
        let expectation = XCTestExpectation(description: "Wait for queue change.")
        weatherService.getWeather(for: .newYork) { success, entireWeather in
            //Then
            XCTAssertFalse(success)
            XCTAssertNil(entireWeather)
            expectation.fulfill()
        }

        wait(for: [expectation], timeout: 0.01)
    }

    func testGetWeatherShouldPostFailedCallbackIfNoData() {
        // Given
        let weatherService = WeatherService(weatherSession: URLSessionFake(data: nil,
                                                                           response: nil,
                                                                           error: nil)
        )

        // When
        let expectation = XCTestExpectation(description: "Wait for queue change.")
        weatherService.getWeather(for: .newYork) { success, entireWeather in
            //Then
            XCTAssertFalse(success)
            XCTAssertNil(entireWeather)
            expectation.fulfill()
        }

        wait(for: [expectation], timeout: 0.01)
    }

    func testGetWeatherShouldPostFailedCallbackIfIncorrectResponse() {
        // Given
        let weatherService = WeatherService(weatherSession: URLSessionFake(
            data: FakeResponseData.weatherCorrectData,
            response: FakeResponseData.responseKO,
            error: nil)
        )

        // When
        let expectation = XCTestExpectation(description: "Wait for queue change.")
        weatherService.getWeather(for: .newYork) { success, entireWeather in
            //Then
            XCTAssertFalse(success)
            XCTAssertNil(entireWeather)
            expectation.fulfill()
        }

        wait(for: [expectation], timeout: 0.01)
    }

    func testGetWeatherShouldPostFailedCallbackIfIncorrectData() {
          // Given
          let weatherService = WeatherService(weatherSession: URLSessionFake(
            data: FakeResponseData.incorrectData,
            response: FakeResponseData.responseOK,
            error: nil)
          )

          // When
          let expectation = XCTestExpectation(description: "Wait for queue change.")
          weatherService.getWeather(for: .newYork) { success, entireWeather in
              //Then
              XCTAssertFalse(success)
              XCTAssertNil(entireWeather)
              expectation.fulfill()
          }

          wait(for: [expectation], timeout: 0.01)
      }

    func testGetWeatherShouldPostSuccessCallbackIfNoErrorAndCorrectData() {
        // Given
        let weatherService = WeatherService(weatherSession: URLSessionFake(
            data: FakeResponseData.weatherCorrectData,
            response: FakeResponseData.responseOK,
            error: nil)
        )

        // When
        let expectation = XCTestExpectation(description: "Wait for queue change.")
        weatherService.getWeather(for: .newYork) { success, entireWeather in
            //Then
            let city = "New York"
            let description = "overcast clouds"
            let temp = 17.85

            XCTAssertTrue(success)
            XCTAssertNotNil(entireWeather)
            XCTAssertEqual(city, entireWeather?.name)
            XCTAssertEqual(description, entireWeather?.weather[0].weatherDescription)
            XCTAssertEqual(temp, entireWeather?.main.temp)

            expectation.fulfill()
        }

        wait(for: [expectation], timeout: 0.01)
    }

}
