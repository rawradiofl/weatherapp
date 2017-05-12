//
//  RainShineCloudVC.swift
//  RainShineCloud
//
//  Created by Scott Martin on 5/9/17.
//  Copyright © 2017 Scott Martin. All rights reserved.
//

import UIKit
import CoreLocation
import Alamofire

class WeatherVC: UIViewController, UITableViewDelegate, UITableViewDataSource, CLLocationManagerDelegate {

    @IBOutlet weak var dateLabel: UILabel!
    @IBOutlet weak var currentTempLabel: UILabel!
    @IBOutlet weak var locationLabel: UILabel!
    @IBOutlet weak var currentConditionsImage: UIImageView!
    @IBOutlet weak var currentConditionsLabel: UILabel!
    @IBOutlet weak var forecastTableView: UITableView!
    
    let locationManager = CLLocationManager()
    var currentLocation: CLLocation!

    var currentWeather: CurrentWeather!
    var forecasts = [Forecast]()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        locationManager.delegate = self
        forecastTableView.delegate = self
        forecastTableView.dataSource = self
        currentWeather = CurrentWeather()

    }


    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        determineLocation()
        currentWeather.downLoadWeatherDetails { [weak self] in
            self?.downloadForecastData {
                self?.updateMainUI()
            }

        }
    }
    
    override func viewDidLayoutSubviews() {

    }
    
    func numberOfSections(in tableView: UITableView) -> Int {
        return 1
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return forecasts.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        if let cell = tableView.dequeueReusableCell(withIdentifier: "Day Cell", for: indexPath) as? ForecastTableViewCell {
            let forecast = forecasts[indexPath.row]
            cell.configureCell(withForecast: forecast)
            return cell
        } else {
            return ForecastTableViewCell()
        }
        
    }
    
    func updateMainUI() {
        dateLabel.text = currentWeather.date
        if let tempValue = currentWeather.currentTemp {
            currentTempLabel.text = tempValue + "°"
        }
        currentConditionsLabel.text = currentWeather.weatherType
        locationLabel.text = currentWeather.cityName
        currentConditionsImage.image = UIImage(named: currentWeather.weatherType)
        forecastTableView.reloadData()
    }
    
    func downloadForecastData(completed: @escaping DownloadComplete) {
        // Download forecast weaather data for tableview
        if let forecastURL = WeatherQueryBuilder(latitude: Location.sharedInstance.latitude, longitude: Location.sharedInstance.longitude).forecastURL {
            Alamofire.request(forecastURL).responseJSON { [weak self] response in
                let result = response.result
                if let dict = result.value as? Dictionary<String, Any> {
                    if let list = dict["list"] as? [Dictionary<String, Any>] {
                        for obj in list {
                            let forecast = Forecast(forecastDict: obj)
                            if let theDate = forecast.date, theDate > Date() {
                                if let count = self?.forecasts.count, count < 10 {
                                    self?.forecasts.append(forecast)
                                }
                            }
                        }
                    }
                }
                completed()
            }
        }
    }
    
    func determineLocation() {
        locationManager.desiredAccuracy = kCLLocationAccuracyBest
        locationManager.requestWhenInUseAuthorization()
        if CLLocationManager.locationServicesEnabled() {
            locationManager.startUpdatingLocation()
            if let location = locationManager.location {
                Location.sharedInstance.latitude = location.coordinate.latitude
                Location.sharedInstance.longitude = location.coordinate.longitude
            }
        }

    }

    func locationManager(_ manager: CLLocationManager, didUpdateLocations locations: [CLLocation]) {
        let userLocation = locations[0] as CLLocation
        Location.sharedInstance.latitude =  userLocation.coordinate.latitude
        Location.sharedInstance.longitude = userLocation.coordinate.longitude
    }

    func locationManager(_ manager: CLLocationManager, didFailWithError error: Error) {
        print("Error: \(error)")
    }
}

