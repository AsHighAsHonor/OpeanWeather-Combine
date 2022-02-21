//
//  OneCallWeather.swift
//  OpenWeather
//
//  Created by Yang Yang on 19/2/22.
//
import Foundation

// MARK: - OneCallWeather
struct OneCallWeather: Codable {
    var lat: Double?
    var lon: Double?
    var timezone: String?
    var timezoneOffset: Int?
    var hourly: [HourlyWeather]?

    enum CodingKeys: String, CodingKey {
        case lat = "lat"
        case lon = "lon"
        case timezone = "timezone"
        case timezoneOffset = "timezone_offset"
        case hourly = "hourly"
    }
}
