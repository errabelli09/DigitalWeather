//
//  Cities.swift
//  SDPWeather
//
//  Created by Anil Errabelli on 26/12/19.
//  Copyright © 2019 Errabelli Anil. All rights reserved.
//

import Foundation

struct searchResults: Codable{
    var search_api: cityReuslts
}
struct cityReuslts: Codable {
    var result: [resultsOfCities]
}
struct resultsOfCities: Codable {
    var areaName: [area]
    var country: [countryName]
    var latitude: String
    var longitude: String

    struct area: Codable {
        var value: String
    }
    struct countryName: Codable {
        var value: String
    }

}
