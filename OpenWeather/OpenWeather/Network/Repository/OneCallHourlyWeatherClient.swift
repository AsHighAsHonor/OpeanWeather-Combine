//
//  OneCallHourlyWeatherClient.swift
//  OpenWeather
//
//  Created by Yang Yang on 19/2/22.
//

import Foundation
import Combine

protocol OneCallHourlyWeatherClientType {
    func fetchWeatherForecast(lat: Double, lon: Double) -> AnyPublisher<OneCallWeather?, NetworkError>
}

struct OneCallHourlyWeatherClient: OneCallHourlyWeatherClientType {
    private let httpClient: HTTPClientType
    private let base: URL

    init(httpClient: HTTPClientType = HTTPClient()) {
        self.httpClient = httpClient
        base = URL(string: "https://api.openweathermap.org")!
    }

    func fetchWeatherForecast(lat: Double, lon: Double) -> AnyPublisher<OneCallWeather?, NetworkError> {
        var api = OneCallHourlyWeatherAPI()
        api.parameters = ["lat": "\(lat)",
                          "lon": "\(lon)",
                          "exclude": "minutely,current,daily,alerts",
                          "units": "metric",
                          "appid": "c4f138942894e83678fcb5c14579091f"]
        return httpClient
            .requestObject(from: base,using: api)
            .eraseToAnyPublisher()
    }
}
