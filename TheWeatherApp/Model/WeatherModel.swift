
//  WeatherModel.swift
//  TheWeatherApp
//
//  Created by Muhammed Salih Bulut on 7.03.

import UIKit


struct WeatherModel {
    let conditionId: Int
    let cityName: String
    let temperature: Double
    
    var temperatureString: String{

        return String(format: "%.1f", temperature)
    }
    var conditinName: String{
        
        switch conditionId {
        case 200...231:
            return "cloud.bolt"
        case 300...321:
            return "cloud.drizzle"
        case 500...531:
            return "cloud.rain"
        case 600...622:
            return "cloud.snow"
        case 701...781:
            return "cloud.fog"
        case 800:
            return "cloud.max"
        case 801...804:
            return "cloud.bolt"
        default:
            return "cloud"
        }
    }
    
    
    
}
