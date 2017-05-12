//
//  WeatherQueryBuilder.swift
//  RainShineCloud
//
//  Created by Scott Martin on 5/9/17.
//  Copyright © 2017 Scott Martin. All rights reserved.
//

import Foundation


struct WeatherQueryBuilder {
    private let baseURL = "http://api.openweathermap.org/data/2.5/"
    private let weather = "weather?"
    private let forecast = "forecast/daily?"
    private let latClause = "lat="
    private let lonClause = "&lon="
    private let AppID = "&appid="
    private let APIKey = "163e96e02f0eaddd4fc8cb94cd9f41b3"
    private let forecastDays = 7
    
    var latitude: Double?
    var longitude: Double?
    
    var forecastURL: String? {
        get {
            if let lat = latitude, let lon = longitude {
                return "\(baseURL)\(forecast)\(latClause)\(lat)\(lonClause)\(lon)&cnt=\(forecastDays)&mode=json\(AppID)\(APIKey)"
            }
            return nil
        }
    }

    var weatherURL: String? {
        get {
            if let lat = latitude, let lon = longitude {
                return "\(baseURL)\(weather)\(latClause)\(lat)\(lonClause)\(lon)\(AppID)\(APIKey)"
            }
            return nil
        }
    }

    
    init(latitude lat: Double, longitude lon: Double) {
        latitude = lat
        longitude = lon
    }
}

