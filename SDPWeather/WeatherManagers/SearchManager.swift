//
//  SearchManager.swift
//  SDPWeather
//
//  Created by Anil Errabelli on 26/12/19.
//  Copyright © 2019 Errabelli Anil. All rights reserved.
//

import Foundation

class SearchManager {

    static func getCity(for city: String, _ completion: @escaping (_ searchCity: SearchResults?) -> Void) {
        guard let url = URL(string: NetworkManager.APIURL.cityCompletion(for: city)) else {
            completion(nil)
            return
        }

        URLSession.shared.dataTask(with: url) { (data, _, error) in
            guard let data = data else {
                return
            }

            do {
                let decoder = JSONDecoder()
                let searchResultsObject = try decoder.decode(SearchResults.self, from: data)
                completion(searchResultsObject)
            } catch {
                print(error.localizedDescription)
                completion(nil)
            }
        }.resume()
    }

}
