
//  WeatherManager.swift
//  TheWeatherApp
//  Created by Muhammed Salih Bulut on 6.02.2024.
//
import UIKit
import CoreLocation

protocol WeatherManagerDelegate {
    func didUpdateWeather(_weatherManager: WeatherManager,weather: WeatherModel)
    func didFailWithError(error: Error)
}
struct WeatherManager{
    let weatherURL = "https://api.openweathermap.org/data/2.5/weather?appid=6803c66cc914e3427631214b24ef74de&units=metric"
    
    var delegate: WeatherManagerDelegate?
    
    func fetchWeather(cityName: String) {
        let urlString = "\(weatherURL)&q=\(cityName)"
        performRequest(with: urlString)
    }
    func fetchWeather(latitude: CLLocationDegrees, longitude: CLLocationDegrees) {
        let urlString = "\(weatherURL)&lat=\(latitude)&lon=\(longitude)"
        performRequest(with: urlString)
    }
    
    func performRequest( with urlString:String){
        
        //1.Create a URL
        if let url = URL(string: urlString) {
            //2.Create a URLSession
            let session = URLSession(configuration: .default)
            /*3.Give the session a task
            let task = session.dataTask(with: url) { (data, response, error) in
                if error != nil{
                    self.delegate?.didFailWithError(error: error!)
                    return
                }
                if let safeData = data{
                    if let weather = self.parseJSON(weatherData: safeData){
                        self.delegate?.didUpdateWeather(_weatherManager: self, weather: weather)
                    }
                }
            }
             */
            let task = session.dataTask(with: url) { (data, response, error) in
                if error != nil {
                    self.delegate?.didFailWithError(error: error!)
                    return
                }
                if let safeData = data {
                    if let weather = self.parseJSON(weatherData: safeData) {
                        self.delegate?.didUpdateWeather(_weatherManager: self, weather: weather)
                    }
                }
            }
                //4.Start the task
                task.resume()
            }
        }
        
        func parseJSON(weatherData: Data)-> WeatherModel?{
            let decoder = JSONDecoder()
            do{
                let decodedData = try decoder.decode(WeatherData.self, from: weatherData)
                //print(decodedData.main.temp)  burası derece yazdırıyor.
                let id = decodedData.weather[0].id
                let temp = decodedData.main.temp
                let name = decodedData.name
                
                let weather = WeatherModel(conditionId: id, cityName: name, temperature: temp)
                //print(weather.conditinName) istedipimiz konumun ismini yazdırır.
                return weather
            }
            catch{
                delegate?.didFailWithError(error: error)
                return nil
                
            }
        }
    }

