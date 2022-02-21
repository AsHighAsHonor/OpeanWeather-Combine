//
//  DateFormatter+Extension.swift
//  OpenWeather
//
//  Created by Yang Yang on 19/2/22.
//

import Foundation

extension DateFormatter {
    
    static let hourlyFormatter: DateFormatter = {
        let formatter = DateFormatter()
        formatter.dateFormat = "HH:mm"
        return formatter
    }()
    
    static let ymdFormatter: DateFormatter = {
        let formatter = DateFormatter()
        formatter.dateFormat = "yyyy-MM-dd"
        return formatter
    }()
}
