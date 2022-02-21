//
//  WeatherTableViewCell.swift
//  OpenWeather
//
//  Created by Yang Yang on 19/2/22.
//

import UIKit

class WeatherTableViewCell: UITableViewCell {

    @IBOutlet weak var iconImageView: UIImageView!
    @IBOutlet weak var tempLabel: UILabel!
    @IBOutlet weak var dateLabel: UILabel!
    
    func configure(with viewModel: WeatherTableCellViewModelType) {
        dateLabel.text = viewModel.time
        tempLabel.text = viewModel.tempAndFeelsLike
        iconImageView.image = viewModel.icon
    }

}
