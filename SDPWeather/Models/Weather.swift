//
//  Weather.swift
//  SDPWeather
//
//  Created by Errabelli Anil on 26/12/19.
//  Copyright © 2019 Errabelli Anil. All rights reserved.
//

import Foundation

struct DataWeather: Codable {
    var data: DataWeatherTime
}
struct DataWeatherTime: Codable {
    var currentCondition: [CurrentWeatherCondition]
    enum CodingKeys: String, CodingKey {
        case currentCondition = "current_condition"
    }
}
struct CurrentWeatherCondition: Codable {
    var weatherIconUrl: [WeatherImage]
    var temp: String
    var humidity: String
    var weatherDesc: [CurrentWeatherDesc]
    struct CurrentWeatherDesc: Codable {
        var value: String
    }
    struct WeatherImage: Codable {
        var value: String
    }
    
    enum CodingKeys: String, CodingKey {
        case temp = "temp_C"
        case weatherIconUrl = "weatherIconUrl"
        case humidity = "humidity"
        case weatherDesc = "weatherDesc"
    }
}
