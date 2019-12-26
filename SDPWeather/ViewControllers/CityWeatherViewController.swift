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

    var latLong = "51.5171,-0.1062"
    var city: String?

    
    var weather: dataWeather?

    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
        
        getWeather()
    }
    
    private func getWeather() {
        WeatherManager.getWeather(for: latLong) { (weather) in
            DispatchQueue.main.async {
                self.weather = weather
                
                print(self.weather)
                
//                let cu = self.weather?.data.currentWeathercondition
//                
//                self.currentWeather.text =
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
