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
        
        static let WWOKey: String = "e6b8915fb40d45dd93b50608192412" // Enter your darkSky API key here
        
    }
    
    struct APIURL {
        
        static func cityCompletion(for search: String) -> String {
            return "https://api.worldweatheronline.com/premium/v1/search.ashx?num_of_results=10&format=json&key=\(NetworkManager.Key.WWOKey)&query=\(search)"
        }
        
        static func cityWeatherData(for placeID: String) ->  String {
            return "https://api.worldweatheronline.com/premium/v1/weather.ashx?q=\(placeID)&num_of_results=3&format=json&key=\(NetworkManager.Key.WWOKey)&cc=yes"
        }
                
    }
        
}
