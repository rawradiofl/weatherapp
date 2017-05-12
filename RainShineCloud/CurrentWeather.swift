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
    
    var currentTemp: String? {
        if _currentTemp == nil {
            _currentTemp = 0.0
        }
        let numberFormatter = NumberFormatter()
        numberFormatter.numberStyle = .decimal
        numberFormatter.maximumFractionDigits = 2
        return numberFormatter.string(from: NSNumber(value: _currentTemp))
    }
    
    func downLoadWeatherDetails(completed: @escaping DownloadComplete) {
        if let url = WeatherQueryBuilder(latitude: Location.sharedInstance.latitude, longitude: Location.sharedInstance.longitude).weatherURL, let currentWeatherURL = URL(string: url) {
            // Alamofire download
            Alamofire.request(currentWeatherURL).responseJSON { [weak self] response in
                let result = response.result
                if let dict = result.value as? Dictionary<String, Any> {
                    if let name = dict["name"] as? String {
                        self?._cityName = name.capitalized
                    }
                    if let weather = dict["weather"] as? [Dictionary<String, Any>] {
                        if let main = weather[0]["main"] as? String {
                            self?._weatherType = main.capitalized
                        }
                    }
                    if let main = dict["main"] as? Dictionary<String, Any> {
                        if let currentTemperature = main["temp"] as? Double {
                            self?._currentTemp = kelvinToFarenheit(from: currentTemperature)                                                    }
                    }
                }
                completed()
            }
        }
    }
    

    
    
}
