//
//  OneCallWeatherViewController.swift
//  OpenWeather
//
//  Created by Yang Yang on 19/2/22.
//

import UIKit
import Combine

// As Hourly forecast for 4 days API is paid plan, i used One Call API (Hourly forecast for 48 hours) to instead.
class OneCallWeatherViewController: UIViewController, StoryboardInitializable {
    
    @IBOutlet weak var currentLocLabel: UILabel!
    @IBOutlet weak var activityView: UIActivityIndicatorView! {
        didSet {
            activityView.startAnimating()
        }
    }
    @IBOutlet weak var weatherTableView: UITableView! {
        didSet {
            weatherTableView.tableFooterView = UIView()
        }
    }
    private var disposables = Set<AnyCancellable>()
    var viewModel: OneCallWeatherViewModelType!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        bindsSetup()
    }
    
    private func bindsSetup() {
        viewModel.hourlyForecastFor48Hours()
        viewModel.oneCallWeatherPublisher
            .sink { [weak self] res in
                if let timezone = res?.timezone {
                    self?.currentLocLabel.text = "Current Timezone: " + timezone
                    self?.weatherTableView.isHidden = false
                    self?.weatherTableView.reloadData()
                }
            }.store(in: &disposables)
    }
    
}

extension OneCallWeatherViewController: UITableViewDelegate, UITableViewDataSource {
    
    func numberOfSections(in tableView: UITableView) -> Int {
        viewModel.headerViewModels.count
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        viewModel.cellViewModelSections[section].count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        if let cell = tableView.dequeueReusableCell(withIdentifier: WeatherTableViewCell.identifier, for: indexPath) as? WeatherTableViewCell {
            cell.configure(with: viewModel.cellViewModelSections[indexPath.section][indexPath.row])
            return cell
        }
        return UITableViewCell()
    }
    
    func tableView(_ tableView: UITableView, titleForHeaderInSection section: Int) -> String? {
        return viewModel.headerViewModels[section].date
    }
    
}
