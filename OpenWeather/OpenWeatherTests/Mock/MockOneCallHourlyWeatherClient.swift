//
//  MockOneCallHourlyWeatherClient.swift
//  OpenWeatherTests
//
//  Created by Yang Yang on 19/2/22.
//

import CoreLocation
import Combine
@testable import OpenWeather

struct MockOneCallHourlyWeatherClient: OneCallHourlyWeatherClientType {
    
    let result = PassthroughSubject<OneCallWeather?, NetworkError>()
    
    func fetchWeatherForecast(lat: Double, lon: Double) -> AnyPublisher<OneCallWeather?, NetworkError> {
        result.eraseToAnyPublisher()
    }
    
    
}
