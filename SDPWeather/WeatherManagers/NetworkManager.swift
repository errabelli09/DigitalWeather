//
//  NetworkManager.swift
//  SDPWeather
//
//  Created by Errabelli Anil on 26/12/19.
//  Copyright © 2019 Errabelli Anil. All rights reserved.
//

import Foundation

class NetworkManager: NSObject {

    struct Key {

        static let WWOKey: String = "e6b8915fb40d45dd93b50608192412" // Enter your WWO API key here
        static let baseUrl: String = "https://api.worldweatheronline.com/premium/v1/" // Enter your baseUrl

    }

    struct APIURL {

        static func cityCompletion(for search: String) -> String {
            return "\(NetworkManager.Key.baseUrl)search.ashx?num_of_results=10&format=json&key=\(NetworkManager.Key.WWOKey)&query=\(search)"
        }

        static func cityWeatherData(for placeID: String) -> String {
            return "\(NetworkManager.Key.baseUrl)weather.ashx?q=\(placeID)&num_of_results=3&format=json&key=\(NetworkManager.Key.WWOKey)&cc=yes"
        }

    }

}
