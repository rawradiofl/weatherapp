//
//  ForecastTableViewCell.swift
//  RainShineCloud
//
//  Created by Scott Martin on 5/12/17.
//  Copyright © 2017 Scott Martin. All rights reserved.
//

import UIKit

class ForecastTableViewCell: UITableViewCell {

    @IBOutlet weak var weatherTypeImage: UIImageView!
    @IBOutlet weak var dayLabel: UILabel!
    @IBOutlet weak var weatherTypeLabel: UILabel!
    @IBOutlet weak var highTempLabel: UILabel!
    @IBOutlet weak var lowTempLabel: UILabel!

    func configureCell(withForecast forecast: Forecast) {
        lowTempLabel.text = forecast.lowTemp + "°"
        highTempLabel.text = forecast.highTemp + "°"
        weatherTypeLabel.text = forecast.weatherType
        weatherTypeImage.image = UIImage(named: forecast.weatherType)
        dayLabel.text = forecast.dayOfWeek
    }
    
}
