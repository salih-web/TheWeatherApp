//
//  ViewController.swift
//  TheWeatherApp
//
//  Created by Muhammed Salih Bulut on 6.02.2024.
//

import UIKit

class ViewController: UIViewController, UITextFieldDelegate, WeatherManagerDelegate{

    @IBOutlet weak var searchText: UITextField!
    @IBOutlet weak var temperaturelabel: UILabel!
    @IBOutlet weak var condinitionview: UIImageView!
    
    
    var weatherManager = WeatherManager()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        searchText.delegate = self
        weatherManager.delegate = self
        // Do any additional setup after loading the view.
    }

    @IBAction func locationButton(_ sender: UIButton) {
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
    func didUpdateWeather(weather: WeatherModel) {
        print(weather.temperature)
    }
    
   
}
