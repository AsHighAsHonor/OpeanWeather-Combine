//
//  MockLocationManager.swift
//  OpenWeatherTests
//
//  Created by Yang Yang on 19/2/22.
//

import CoreLocation
import Combine
@testable import OpenWeather

class MockLocationManager: LocationManagerType {
    
    @Published var status: CLAuthorizationStatus?
    var statusPublished: Published<CLAuthorizationStatus?> { _status }
    var statusPublisher: Published<CLAuthorizationStatus?>.Publisher { $status }
    
    @Published var location: CLLocation?
    var locationPublished: Published<CLLocation?> { _location }
    var locationPublisher: Published<CLLocation?>.Publisher { $location }
    
}
