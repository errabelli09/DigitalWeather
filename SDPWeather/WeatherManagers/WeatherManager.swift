//
//  WeatherManager.swift
//  SDPWeather
//
//  Created by Errabelli Anil on 26/12/19.
//  Copyright © 2019 Errabelli Anil. All rights reserved.
//

import Foundation

class WeatherManager {

    static func getWeather(for cityLatLong: String, _ completion: @escaping (_ weather: DataWeather?) -> Void) {
        guard let url = URL(string: NetworkManager.APIURL.cityWeatherData(for: cityLatLong)) else {
            completion(nil)
            return
        }

        URLSession.shared.dataTask(with: url) { (data, _, error) in
            guard let data = data else {
                return
            }

            do {
                let decoder = JSONDecoder()
                let weatherObject = try decoder.decode(DataWeather.self, from: data)
                completion(weatherObject)
            } catch {
                print(error.localizedDescription)
                completion(nil)
            }
        }.resume()
    }

}
