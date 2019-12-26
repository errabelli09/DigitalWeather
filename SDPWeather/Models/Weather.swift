//
//  Weather.swift
//  SDPWeather
//
//  Created by Errabelli Anil on 26/12/19.
//  Copyright © 2019 Errabelli Anil. All rights reserved.
//

import Foundation

struct dataWeather: Codable {
    
    var data: [currentWeathercondition]
    
    struct currentWeathercondition: Codable {
        
        var weatherIconUrl: [weatherImage]
        var temp_C: String
        var humidity: String
        var weatherDesc: [currentWeatherDesc]
        
        struct currentWeatherDesc: Codable {
            var value: String
        }
        struct weatherImage: Codable {
            var value: String
        }
    }
}


    
