//
//  WeatherTableCellViewModel.swift
//  OpenWeather
//
//  Created by Yang Yang on 19/2/22.
//

import UIKit

protocol WeatherTableCellViewModelType {
    var time: String? { get }
    var tempAndFeelsLike: String? { get }
    var icon: UIImage? { get }
}

struct WeatherTableCellViewModel: WeatherTableCellViewModelType {
    
    var time: String? {
        let formatter = DateFormatter.hourlyFormatter
        return formatter.string(from: hourlyWeather.date)
    }
    var icon: UIImage? {
        hourlyWeather.weather?.first?.icon?.image
    }
    var tempAndFeelsLike: String? {
        "\(hourlyWeather.temp ?? 0) °C / Feels like \(hourlyWeather.feelsLike ?? 0) °C"
    }
    
    var hourlyWeather: HourlyWeather
  
}
