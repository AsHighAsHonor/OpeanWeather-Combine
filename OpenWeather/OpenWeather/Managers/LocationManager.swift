//
//  LocationManager.swift
//  OpenWeather
//
//  Created by Yang Yang on 19/2/22.
//

import Foundation
import CoreLocation
import Combine

protocol LocationManagerType {
    // Define (wrapped value)
    var status: CLAuthorizationStatus? { get }
    // Define Published property wrapper
    var statusPublished: Published<CLAuthorizationStatus?> { get }
    // Define publisher
    var statusPublisher: Published<CLAuthorizationStatus?>.Publisher { get }
    
    // Define location (wrapped value)
    var location: CLLocation? { get }
    // Define location Published property wrapper
    var locationPublished: Published<CLLocation?> { get }
    // Define location publisher
    var locationPublisher: Published<CLLocation?>.Publisher { get }
}

class LocationManager: NSObject, ObservableObject, LocationManagerType {
    
    private let locationManager = CLLocationManager()
    
    @Published var status: CLAuthorizationStatus?
    var statusPublished: Published<CLAuthorizationStatus?> { _status }
    var statusPublisher: Published<CLAuthorizationStatus?>.Publisher { $status }
    
    @Published var location: CLLocation?
    var locationPublished: Published<CLLocation?> { _location }
    var locationPublisher: Published<CLLocation?>.Publisher { $location }
    
    override init() {
        super.init()
        locationManager.desiredAccuracy = kCLLocationAccuracyThreeKilometers
        requestLocationPermission(stateHandler: nil)
    }
    
    func requestLocationPermission(stateHandler: ((CLAuthorizationStatus, _ stateChanged: Bool) -> Void)? = nil) {
        let status = locationManager.authorizationStatus
        switch status {
        case .notDetermined:
            locationManager.delegate = self
            locationManager.requestAlwaysAuthorization()
        case .restricted, .denied, .authorizedAlways, .authorizedWhenInUse:
            locationManager.delegate = self
            locationManager.startUpdatingLocation()
            stateHandler?(status, false)
        @unknown default:
            fatalError("User permission location failure")
        }
    }
    
}

extension LocationManager: CLLocationManagerDelegate {
    func locationManager(_ manager: CLLocationManager, didChangeAuthorization status: CLAuthorizationStatus) {
        if status == .authorizedAlways || status == .authorizedWhenInUse {
            manager.startUpdatingLocation()
        }
        self.status = status
    }
    
    func locationManager(_ manager: CLLocationManager, didUpdateLocations locations: [CLLocation]) {
        guard let location = locations.last else { return }
        self.location = location
    }
}

extension CLLocation {
    var latitude: Double { coordinate.latitude }
    var longitude: Double { coordinate.longitude }
}

