//
//  WeatherData.swift
//  TheWeatherApp
//
//  Created by Muhammed Salih Bulut on 5.03.2024.
//

import UIKit

struct WeatherData: Codable {
    let name: String
    let main: Main
    let weather: [Weather]
}

struct Main: Codable {
    let temp: Double
}

struct Weather: Codable {
    let description: String
    let id: Int
}
