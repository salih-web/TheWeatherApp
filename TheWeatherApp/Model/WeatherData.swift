//
//  WeatherData.swift
//  TheWeatherApp
//
//  Created by Muhammed Salih Bulut on 5.03.2024.
//

import UIKit

struct WeatherData: Decodable {
    let name : String
    let main: Main
    let weather: [Weather]
}

struct Main:Decodable{
    
    let temp: Double
    
}

struct Weather:Decodable{
    
    let id: Int
}
