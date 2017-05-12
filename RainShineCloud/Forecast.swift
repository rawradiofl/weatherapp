//
//  Forecast.swift
//  RainShineCloud
//
//  Created by Scott Martin on 5/11/17.
//  Copyright © 2017 Scott Martin. All rights reserved.
//

import UIKit
import Alamofire

class Forecast {
    private var _dayOfWeek: String!
    private var _weatherType: String!
    private var _highTemp: String!
    private var _lowTemp: String!
    
    var dayOfWeek: String {
        if _dayOfWeek == nil {
            _dayOfWeek = "--"
        }
        return _dayOfWeek
    }
    
    var weatherType: String {
        if _weatherType == nil {
            _weatherType = "--"
        }
        return _weatherType
    }
    
    var highTemp: String {
        if _highTemp == nil {
            _highTemp = "--"
        }
        return _highTemp
    }
    
    var lowTemp: String {
        if _lowTemp == nil {
            _lowTemp = "--"
        }
        return _lowTemp
    }

    init(forecastDict: Dictionary<String, Any>) {
        if let temperature = forecastDict["temp"] as? Dictionary<String, Any> {
            if let minTemp = temperature["min"] as? Double {
                _lowTemp = formatTemperature(from: kelvinToFarenheit(from: minTemp))
            }
            
            if let maxTemp = temperature["max"] as? Double {
                _highTemp = formatTemperature(from: kelvinToFarenheit(from: maxTemp))
            }
        }
        
        if let weather = forecastDict["weather"] as? [Dictionary<String, Any>] {
            if let main = weather[0]["main"] as? String {
                _weatherType = main
            }
        }
        
        if let date = forecastDict["dt"] as? Double {
            let unixConvertedDate = Date(timeIntervalSince1970: date)
            print(unixConvertedDate)
            _dayOfWeek = unixConvertedDate.dayOfTheWeek()
        }
    }
    

    
}









