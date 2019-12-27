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

    var weather: [CurrentWeatherCondition]?

    // MARK: - ViewController

    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.

        self.title = cityData?.areaName[0].value
    }

    override func viewDidAppear(_ animated: Bool) {
        latLong = (cityData?.latitude)! + "," + (cityData?.longitude)!
        getWeather()

        var cityDataSave: [[String: Any]] = []
        cityDataSave.append(["cityName": cityData?.areaName[0].value ?? "nope", "country": cityData?.country[0].value ?? "nope", "latLong": latLong])

        UserDefaults.standard.set(cityDataSave, forKey: "searchedCities")

        if let loadedCart = UserDefaults.standard.array(forKey: "searchedCities") as? [[String: Any]] {
            print(loadedCart)  // [[cityName: 19.99, country: 1, latLong: A]
            for item in loadedCart {
                print(item["cityName"]  as? String ?? "nope")    // A, B
                print(item["country"] as? String ?? "nope")
                print(item["latLong"]   as? String ?? "nope")    // 19.99, 4.99
            }
        }
    }
    // MARK: - VC Methods
    private func getWeather() {
        WeatherManager.getWeather(for: latLong) { (weather) in
            DispatchQueue.main.async {
                self.weather = weather?.data.currentCondition
                print(self.weather as Any)
                self.currentWeather.text = self.weather?[0].weatherDesc[0].value
                self.currentHumidity.text = (self.weather?[0].humidity ?? "0") + "%"
                self.currentTemperature.text = (self.weather?[0].temp ?? "0") + "°C"
                let url = URL(string: (self.weather?[0].weatherIconUrl[0].value)!)

                DispatchQueue.global().async {
                    let data = try? Data(contentsOf: url!) //make sure your image in this url does exist, otherwise unwrap in a if let check / try-catch
                    DispatchQueue.main.async {
                        self.weatherImageView.image = UIImage(data: data!)
                    }
                }
            }
        }
    }

    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destination.
        // Pass the selected object to the new view controller.
    }
    */

}
