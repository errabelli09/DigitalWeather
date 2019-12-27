//
//  SDPWeatherTests.swift
//  SDPWeatherTests
//
//  Created by Errabelli Anil on 27/12/19.
//  Copyright © 2019 Errabelli Anil. All rights reserved.
//

import XCTest
@testable import SDPWeather

class SDPWeatherTests: XCTestCase {

    override func setUp() {
        // Put setup code here. This method is called before the invocation of each test method in the class.
    }

    override func tearDown() {
        // Put teardown code here. This method is called after the invocation of each test method in the class.
    }

    func testExample() {
        // This is an example of a functional test case.
        // Use XCTAssert and related functions to verify your tests produce the correct results.
    }

    func testPerformanceExample() {
        // This is an example of a performance test case.
        self.measure {
            // Put the code you want to measure the time of here.
        }
    }

    func testGeneratingUrlRequestForCitySearchForCityNameHasNoSpaces() {
        guard let searchUrl = URL(string: NetworkManager.APIURL.cityCompletion(for: "Hyde")) else {
            XCTFail("UrlRequest Failed")
            return
        }
        let urlShouldBe
            = "https://api.worldweatheronline.com/premium/v1/search.ashx?num_of_results=10&format=json&key=e6b8915fb40d45dd93b50608192412&query=Hyde"
        let generatedUrl = searchUrl
        XCTAssertEqual(generatedUrl, URL(string: urlShouldBe))
    }

    func testGeneratingUrlRequestForCitySearchForCityNameHasSpaces() {
        guard let searchUrl = URL(string: NetworkManager.APIURL.cityCompletion(for: "palo atlo")) else {
            XCTFail("UrlRequest Failed")
            return
        }
        let urlShouldBe
            = "https://api.worldweatheronline.com/premium/v1/search.ashx?num_of_results=10&format=json&key=e6b8915fb40d45dd93b50608192412&query=palo%20atlo"
        let generatedUrl = searchUrl
        XCTAssertEqual(generatedUrl, URL(string: urlShouldBe))
    }
    
    func testGeneratingUrlRequestForCityWeatherDetails() {
        guard let citySearchUrl =   URL(string: NetworkManager.APIURL.cityWeatherData(for: "28.67,77.22")) else {
           XCTFail("UrlRequest Failed")
           return
        }
        let urlShouldBe
            = "https://api.worldweatheronline.com/premium/v1/weather.ashx?q=28.67,77.22&num_of_results=3&format=json&key=e6b8915fb40d45dd93b50608192412&cc=yes"
        let generatedUrl = citySearchUrl
        XCTAssertEqual(generatedUrl, URL(string: urlShouldBe))
    }
}
