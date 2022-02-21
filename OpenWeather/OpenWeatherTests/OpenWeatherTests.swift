//
//  OpenWeatherTests.swift
//  OpenWeatherTests
//
//  Created by Yang Yang on 19/2/22.
//

import XCTest
import Combine
import CoreLocation
@testable import OpenWeather

class OpenWeatherTests: XCTestCase {
    
    private var disposables: Set<AnyCancellable>!
    private var viewModel: OneCallWeatherViewModel!
    private var manager: MockLocationManager!
    private var client: MockOneCallHourlyWeatherClient!

    override func setUp() {
        disposables = Set<AnyCancellable>()
        manager = MockLocationManager()
        client = MockOneCallHourlyWeatherClient()
        viewModel = OneCallWeatherViewModel(client: client, locationManager: manager)
    }

    func testHourlyForecastWhenLocationDisabled()  {
        //Given
        manager.status = .denied
        //When
        viewModel.hourlyForecastFor48Hours()

        //Then
        XCTAssertTrue(viewModel.cellViewModelSections.count == 0)
        XCTAssertTrue(viewModel.headerViewModels.count == 0)
        
    }
    
    func testHourlyForecastWhenLocationEnabled()  {
        //Given
        let expectation = expectation(description: "Publishes one value then finishes")
        var error: Error?
        let forecast = "response".readJSONFromFile()?.parse(type: OneCallWeather.self)
        manager.location = CLLocation(latitude: -34.933, longitude: 138.600)
        manager.status = .authorizedAlways
        client.result.send(forecast)
        
        //When
        viewModel.hourlyForecastFor48Hours()
        
        viewModel
            .$oneCallWeather
            .sink(receiveCompletion: { completion in
                switch completion {
                case .finished:
                    break
                case .failure(let encounteredError):
                    error = encounteredError
                }

                expectation.fulfill()
            }, receiveValue: { value in
                expectation.fulfill()
            }).store(in: &disposables)

        //Then
        wait(for: [expectation], timeout: 5)
        XCTAssertNil(error)
        
    }
   
}
