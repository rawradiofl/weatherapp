//
//  Extensions+Utilities.swift
//  RainShineCloud
//
//  Created by Scott Martin on 5/12/17.
//  Copyright © 2017 Scott Martin. All rights reserved.
//

import Foundation


func kelvinToFarenheit(from temperatureInK: Double) -> Double {
    return (temperatureInK * (9/5) - 459.67)
}

func formatTemperature(from temperature: Double) -> String? {
    let numberFormatter = NumberFormatter()
    numberFormatter.numberStyle = .decimal
    numberFormatter.maximumFractionDigits = 2
    numberFormatter.minimumFractionDigits = 2
    return numberFormatter.string(from: NSNumber(value: temperature))
}

extension Date {
    func dayOfTheWeek() -> String {
        let dateFormatter = DateFormatter()
        dateFormatter.dateFormat = "EEEE"
        return dateFormatter.string(from: self)
    }
}

