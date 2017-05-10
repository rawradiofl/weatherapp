//
//  CurrentWeather.swift
//  RainShineCloud
//
//  Created by Scott Martin on 5/9/17.
//  Copyright © 2017 Scott Martin. All rights reserved.
//

import UIKit
import Alamofire

typealias DownloadComplete = () -> ()

class CurrentWeather {
    private var _cityName: String!
    private var _date: String!
    private var _weatherType: String!
    private var _currentTemp: Double!
    
    var cityName: String {
        if _cityName == nil {
            _cityName = ""
        }
        return _cityName
    }
    
    var date: String {
        if _date == nil {
            _date = ""
        }
        let dateFormatter = DateFormatter()
        dateFormatter.dateStyle = .long
        dateFormatter.timeStyle = .none
        let currentDate = dateFormatter.string(from: Date())
        _date = "Today, \(currentDate)"
        return _date
    }
    
    var weatherType: String {
        if _weatherType == nil {
            _weatherType = ""
        }
        return _weatherType
    }
    
    var currentTemp: Double {
        if _currentTemp == nil {
            _currentTemp = 0.0
        }

        return _currentTemp
    }
    
    func downLoadWeatherDetails(completed: @escaping DownloadComplete) {
        if let url = WeatherQueryBuilder(latitude: 25, longitude: -80).latLonURL, let currentWeatherURL = URL(string: url) {
            // Alamofire download
            Alamofire.request(currentWeatherURL).responseJSON { [weak self] response in
                let result = response.result
                if let dict = result.value as? Dictionary<String, AnyObject> {
                    if let name = dict["name"] as? String {
                        self?._cityName = name.capitalized
                        //print(self?._cityName)
                    }
                    if let weather = dict["weather"] as? [Dictionary<String, AnyObject>] {
                        if let main = weather[0]["main"] as? String {
                            self?._weatherType = main.capitalized
                            //print("\(self?.weatherType)")
                        }
                    }
                    if let main = dict["main"] as? Dictionary<String, AnyObject> {
                        if let currentTemperature = main["temp"] as? Double {
                            let kelvinToFarenheit = ((currentTemperature - 273) * (9/5)) + 32
                            self?._currentTemp = kelvinToFarenheit
                            //print(self?.currentTemp)
                        }
                    }
                }
                completed()
            }
        }
    }
    
    
    
    
}
