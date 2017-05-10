//
//  WeatherQueryBuilder.swift
//  RainShineCloud
//
//  Created by Scott Martin on 5/9/17.
//  Copyright © 2017 Scott Martin. All rights reserved.
//

import Foundation


struct WeatherQueryBuilder {
    private let baseURL = "http://api.openweathermap.org/data/2.5/weather?"
    private let latitudeClause = "lat="
    private let longitudeClause = "&lon="
    private let AppID = "&appid="
    private let APIKey = "163e96e02f0eaddd4fc8cb94cd9f41b3"
    var latitude: Double?
    var longitude: Double?
    
    var latLonURL: String? {
        get {
            if let lat = latitude, let lon = longitude {
                return "\(baseURL)\(latitudeClause)\(lat)\(longitudeClause)\(lon)\(AppID)\(APIKey)"
            }
            return nil
        }
    }
    
    init(latitude lat: Double, longitude lon: Double) {
        latitude = lat
        longitude = lon
    }
}

