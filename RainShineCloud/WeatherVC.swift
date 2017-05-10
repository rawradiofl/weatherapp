//
//  RainShineCloudVC.swift
//  RainShineCloud
//
//  Created by Scott Martin on 5/9/17.
//  Copyright © 2017 Scott Martin. All rights reserved.
//

import UIKit

class WeatherVC: UIViewController, UITableViewDelegate, UITableViewDataSource {

    @IBOutlet weak var dateLabel: UILabel!
    @IBOutlet weak var currentTempLabel: UILabel!
    @IBOutlet weak var locationLabel: UILabel!
    @IBOutlet weak var currentConditionsImage: UIImageView!
    @IBOutlet weak var currentConditionsLabel: UILabel!
    @IBOutlet weak var forcastTableView: UITableView!

    var currentWeather: CurrentWeather!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        forcastTableView.delegate = self
        forcastTableView.dataSource = self
        
        currentWeather = CurrentWeather()
        currentWeather.downLoadWeatherDetails { [weak self] in
            self?.updateMainUI()
        }

        
    }
    
    override func viewDidLayoutSubviews() {

    }
    
    func numberOfSections(in tableView: UITableView) -> Int {
        return 1
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return 6
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "Day Cell", for: indexPath)
        return cell
    }
    
    func updateMainUI() {
        dateLabel.text = currentWeather.date
        let numberFormatter = NumberFormatter()
        numberFormatter.numberStyle = .decimal
        numberFormatter.maximumFractionDigits = 2
        if let value = numberFormatter.string(from: NSNumber(value: currentWeather.currentTemp)) {
            currentTempLabel.text = value + "°"        }
        currentConditionsLabel.text = currentWeather.weatherType
        locationLabel.text = currentWeather.cityName
        currentConditionsImage.image = UIImage(named: currentWeather.weatherType)
    }
    
    
    
    

}

