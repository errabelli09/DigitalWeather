//
//  Cities.swift
//  SDPWeather
//
//  Created by Anil Errabelli on 26/12/19.
//  Copyright © 2019 Errabelli Anil. All rights reserved.
//

import Foundation

struct SearchResults: Codable {
    var searchApi: CityReuslts
    enum CodingKeys: String, CodingKey {
        case searchApi = "search_api"
    }
}
struct CityReuslts: Codable {
    var result: [ResultsOfCities]
}
struct ResultsOfCities: Codable {
    var areaName: [Area]
    var country: [CountryName]
    var latitude: String
    var longitude: String

    struct Area: Codable {
        var value: String
    }
    struct CountryName: Codable {
        var value: String
    }
}
