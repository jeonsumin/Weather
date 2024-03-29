//
//  WeatherInfomation.swift
//  Weather
//
//  Created by Terry on 2022/01/07.
//

import Foundation

struct WeatherInfomotion :Codable {
    let weather: [Weather]
    let temp: Temp
    let name: String
    
    enum CodingKeys: String, CodingKey {
        case weather, name
        case temp = "main"
        
    }
}

struct Weather: Codable {
    let id          : Int
    let main        : String
    let description : String
    let icon        : String
}

struct Temp :Codable {
    let temp : Double
    let feelsLike : Double
    let minTemp : Double
    let maxTemp : Double
    
    enum CodingKeys: String, CodingKey {
        case temp
        case feelsLike = "feels_like"
        case minTemp = "temp_min"
        case maxTemp = "temp_max"
    }
}
