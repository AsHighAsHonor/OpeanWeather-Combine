//
//  HourlyWeather.swift
//  OpenWeather
//
//  Created by Yang Yang on 19/2/22.
//

import Foundation

// MARK: - HourlyWeather
struct HourlyWeather: Codable {
    var dt: Int
    var temp: Double?
    var feelsLike: Double?
    var pressure: Int?
    var humidity: Int?
    var dewPoint: Double?
    var uvi: Double?
    var clouds: Int?
    var visibility: Int?
    var windSpeed: Double?
    var windDeg: Int?
    var windGust: Double?
    var weather: [Weather]?
    var pop: Double?
    
    var date: Date {
        let interval = TimeInterval(dt)
        return Date(timeIntervalSince1970: interval)
    }


    enum CodingKeys: String, CodingKey {
        case dt = "dt"
        case temp = "temp"
        case feelsLike = "feels_like"
        case pressure = "pressure"
        case humidity = "humidity"
        case dewPoint = "dew_point"
        case uvi = "uvi"
        case clouds = "clouds"
        case visibility = "visibility"
        case windSpeed = "wind_speed"
        case windDeg = "wind_deg"
        case windGust = "wind_gust"
        case weather = "weather"
        case pop = "pop"
    }
}
