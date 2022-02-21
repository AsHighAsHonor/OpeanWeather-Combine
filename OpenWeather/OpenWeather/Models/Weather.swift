//
//  Weather.swift
//  OpenWeather
//
//  Created by Yang Yang on 19/2/22.
//

import Foundation
import UIKit

// MARK: - Weather
struct Weather: Codable {
    var id: Int?
    var main: Main?
    var weatherDescription: String?
    var icon: Icon?

    enum CodingKeys: String, CodingKey {
        case id = "id"
        case main = "main"
        case weatherDescription = "description"
        case icon = "icon"
    }
}

enum Main: String, Codable {
    case clear = "Clear"
    case clouds = "Clouds"
    case rain = "Rain"
    case snow = "Snow"
    case extreme = "Extreme"
}

enum Icon: String, Codable {
    case the01D = "01d"
    case the01N = "01n"
    case the02N = "02n"
    case the02D = "02d"
    case the03D = "03d"
    case the03N = "03n"
    case the04D = "04d"
    case the04N = "04n"
    case the09D = "09d"
    case the09N = "09n"
    case the10D = "10d"
    case the10N = "10n"
    case the11D = "11d"
    case the11N = "11n"
    case the13D = "13d"
    case the13N = "13n"
    case the50D = "50d"
    case the50N = "50n"
    
    var image: UIImage? {
        return UIImage(named: self.rawValue)
    }
}
