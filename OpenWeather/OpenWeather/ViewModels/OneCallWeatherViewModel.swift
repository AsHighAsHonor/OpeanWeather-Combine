//
//  OneCallWeatherViewModel.swift
//  OpenWeather
//
//  Created by Yang Yang on 19/2/22.
//

import Combine
import Foundation

protocol OneCallWeatherViewModelType {
    // Define (wrapped value)
    var oneCallWeather: OneCallWeather? { get }
    // Define Published property wrapper
    var oneCallWeatherPublished: Published<OneCallWeather?> { get }
    // Define publisher
    var oneCallWeatherPublisher: Published<OneCallWeather?>.Publisher { get }
    
    // output viewModels for tableview
    var cellViewModelSections: [[WeatherTableCellViewModelType]] { set get }
    var headerViewModels: [WeatherTableHeaderViewModel] { set get }
    
    func hourlyForecastFor48Hours()
}

class OneCallWeatherViewModel: ObservableObject, OneCallWeatherViewModelType {
    
    
    private let weatherClient: OneCallHourlyWeatherClientType
    private let manager: LocationManagerType
    private var disposables = Set<AnyCancellable>()
    
    @Published var oneCallWeather: OneCallWeather?
    var oneCallWeatherPublished: Published<OneCallWeather?>{ _oneCallWeather }
    var oneCallWeatherPublisher: Published<OneCallWeather?>.Publisher { $oneCallWeather }
    
    @Published var locationPermissionsEnabled: Bool = false
    var cellViewModelSections: [[WeatherTableCellViewModelType]] = []
    var headerViewModels: [WeatherTableHeaderViewModel] = []
    
    init(client: OneCallHourlyWeatherClientType = OneCallHourlyWeatherClient(),
         locationManager: LocationManagerType = LocationManager()) {
        weatherClient = client
        manager = locationManager
        bindingsSetup()
    }
    
    private func bindingsSetup() {
        manager.statusPublisher
            .receive(on: RunLoop.main)
            .sink { [weak self] status in
                self?.locationPermissionsEnabled = [.authorizedAlways, .authorizedWhenInUse].contains(status)
            }.store(in: &disposables)
        
    }
    
    func hourlyForecastFor48Hours() {
        manager.locationPublisher
            .combineLatest($locationPermissionsEnabled)
            .filter { ($1 == true && $0 != nil) }
            .debounce(for: 0.5, scheduler: RunLoop.main)
            .print()
            .map { [weak self] in
                self?.weatherClient.fetchWeatherForecast(lat: $0.0?.latitude ?? -34.933,
                                                         lon: $0.0?.longitude ?? 138.600) ?? CurrentValueSubject(nil).eraseToAnyPublisher()}
            .switchToLatest()
            .receive(on: RunLoop.main)
            .sink(receiveCompletion: { _ in
            }, receiveValue: { [weak self] oneCallWeather in
                
                self?.cellViewModelSections.removeAll()
                self?.headerViewModels.removeAll()
                
                guard let cellViewModels = oneCallWeather?.hourly?.compactMap ({ WeatherTableCellViewModel(hourlyWeather: $0) }), cellViewModels.count != 0 else {
                    // reload table view
                    self?.oneCallWeather = oneCallWeather
                    return
                }
                //sort weather by day
                let groupedCellViewModels = Dictionary(grouping: cellViewModels) {
                    Calendar.current.dateComponents([.day, .year, .month], from: $0.hourlyWeather.date)
                }
                    .sorted { Calendar.current.date(from: $0.key)! < Calendar.current.date(from: $1.key)! }
                
                self?.headerViewModels.append(contentsOf: groupedCellViewModels.compactMap {  WeatherTableHeaderViewModel(date: Calendar.current.date(from: $0.key)?.toYMDDateStr() ?? "") })
                self?.cellViewModelSections.append(contentsOf: groupedCellViewModels.compactMap { $0.value })
                
                self?.oneCallWeather = oneCallWeather
            }).store(in: &disposables)
    }
    
}


