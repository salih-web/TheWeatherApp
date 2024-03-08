//
//  ViewController.swift
//  TheWeatherApp
//
//  Created by Muhammed Salih Bulut on 6.02.2024.
//

import UIKit
import CoreLocation
class ViewController: UIViewController, UITextFieldDelegate, WeatherManagerDelegate{

    @IBOutlet weak var searchText: UITextField!
    @IBOutlet weak var temperaturelabel: UILabel!
    @IBOutlet weak var condinitionview: UIImageView!
    
    
    var weatherManager = WeatherManager()
    let locationManager = CLLocationManager()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        locationManager.delegate = self
        locationManager.requestWhenInUseAuthorization()
        locationManager.requestLocation()
        
        searchText.delegate = self
        weatherManager.delegate = self
    }

    @IBAction func locationButton(_ sender: UIButton) {
        locationManager.requestLocation()
        searchText.endEditing(true)
    }
    
    func textFieldShouldReturn(_ textField: UITextField) -> Bool {
        print(searchText.text!)
        searchText.endEditing(true)
        return true
    }
    
    func textFieldShouldEndEditing(_ textField: UITextField) -> Bool {
        if textField.text != "" {
            return true
        } else {
            textField.placeholder = "Type something"
            return false
        }
    }
    
    func textFieldDidEndEditing(_ textField: UITextField) {
        if let city = textField.text{
            weatherManager.fetchWeather(cityName: city)
        }
        textField.text = ""
    }
    @IBAction func searchButton(_ sender: UIButton) {
        searchText.endEditing(true)
        print(searchText.text!)
    }
    func didUpdateWeather(_weatherManager: WeatherManager,weather: WeatherModel)
    {
        DispatchQueue.main.sync {
            temperaturelabel.text = weather.temperatureString
            condinitionview.image = UIImage(systemName: weather.conditinName)
        }
    }
    
    func didFailWithError(error: Error){
        print(error)
    }
}
//MARK: -CLLocationManagerDelegate

 extension ViewController: CLLocationManagerDelegate{
    func locationManager(_ manager: CLLocationManager, didUpdateLocations locations: [CLLocation]) {
        if let location = locations.last{
            locationManager.stopUpdatingLocation()
            let lat = location.coordinate.latitude
            let lon = location.coordinate.longitude
            weatherManager.fetchWeather(latitude: lat, longitude: lon)
        }
    }
    func locationManager(_ manager: CLLocationManager, didFailWithError error:Error) {
        print(error)
    }
}

