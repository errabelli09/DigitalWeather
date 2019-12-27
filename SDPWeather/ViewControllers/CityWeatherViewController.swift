//
//  CityWeatherViewController.swift
//  SDPWeather
//
//  Created by Errabelli Anil on 26/12/19.
//  Copyright © 2019 Errabelli Anil. All rights reserved.
//

import UIKit

class CityWeatherViewController: UIViewController {

    // MARK: - Outlets

    @IBOutlet weak var weatherImageView: UIImageView!
    @IBOutlet weak var currentWeather: UILabel!
    @IBOutlet weak var currentTemperature: UILabel!
    @IBOutlet weak var currentHumidity: UILabel!

    // MARK: - Properties

    var latLong = String()
    var cityData: ResultsOfCities?
    var cityDataDefaults = [String: Any]()
    var searched = Bool()

    var weather: [CurrentWeatherCondition]?

    // MARK: - ViewController

    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.

        self.title = cityData?.areaName[0].value
    }

    override func viewDidAppear(_ animated: Bool) {
        switch searched {
        case true:
            latLong = (cityData?.latitude)! + "," + (cityData?.longitude)!
            var cityDataSave: [[String: Any]] = []
            cityDataSave.append(["cityName": cityData?.areaName[0].value ?? "nope", "country": cityData?.country[0].value ?? "nope", "latLong": latLong])

            UserDefaults.standard.set(cityDataSave, forKey: "searchedCities")

            if let loadedCart = UserDefaults.standard.array(forKey: "searchedCities") as? [[String: Any]] {
                print(loadedCart)  // [[cityName: "Bangalore", country: "India", latLong: "19.99,4.99"]
                for item in loadedCart {
                    print(item["cityName"]  as? String ?? "nope")    // Bangalore
                    print(item["country"] as? String ?? "nope")    // India
                    print(item["latLong"]   as? String ?? "nope")    // 19.99,4.99
                }
            }
        default:
            latLong = (cityDataDefaults["latLong"])! as? String ?? "0"
        }
        getWeather()

    }
    
    // MARK: - VC Methods
    private func getWeather() {
        ReusableClasses.reusableSharedInstance.showIndicatorViewOnScreen(viewController: self)

        WeatherManager.getWeather(for: latLong) { (weather) in
            DispatchQueue.main.async {
                ReusableClasses.reusableSharedInstance.hideIndicatorViewOnScreen(viewController: self)
                self.weather = weather?.data.currentCondition
                print(self.weather as Any)
                self.currentWeather.text = self.weather?[0].weatherDesc[0].value
                self.currentHumidity.text = (self.weather?[0].humidity ?? "0") + "%"
                self.currentTemperature.text = (self.weather?[0].temp ?? "0") + "°C"
                let url = URL(string: (self.weather?[0].weatherIconUrl[0].value)!)
                self.weatherImageView.load(url: url!)
            }
        }
    }

}

extension UIImageView {
    func load(url: URL) {
        DispatchQueue.global().async { [weak self] in
            if let data = try? Data(contentsOf: url) {
                if let image = UIImage(data: data) {
                    DispatchQueue.main.async {
                        self?.image = image
                    }
                }
            }
        }
    }
}
