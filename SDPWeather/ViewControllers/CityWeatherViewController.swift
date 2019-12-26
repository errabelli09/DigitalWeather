//
//  CityWeatherViewController.swift
//  SDPWeather
//
//  Created by Errabelli Anil on 26/12/19.
//  Copyright © 2019 Errabelli Anil. All rights reserved.
//

import UIKit

class CityWeatherViewController: UIViewController {
    
    //MARK:- Outlets

    @IBOutlet weak var weatherImageView: UIImageView!
    @IBOutlet weak var currentWeather: UILabel!
    @IBOutlet weak var currentTemperature: UILabel!
    @IBOutlet weak var currentHumidity: UILabel!
    
    //MARK:- Properties

    var latLong = String()
    var city: String?

    
    var weather: [currentWeatherCondition]?

    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
    
        self.title = city
        getWeather()
    }
    
    private func getWeather() {
        WeatherManager.getWeather(for: latLong) { (weather) in
            DispatchQueue.main.async {
                self.weather = weather?.data.current_condition
                
                print(self.weather as Any)
                
                self.currentWeather.text = self.weather?[0].weatherDesc[0].value
                self.currentHumidity.text = (self.weather?[0].humidity ?? "0") + "%"
                self.currentTemperature.text = (self.weather?[0].temp_C ?? "0") + "°C"
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
