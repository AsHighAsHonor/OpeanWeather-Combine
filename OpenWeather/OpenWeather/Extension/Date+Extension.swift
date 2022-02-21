//
//  Date+Extension.swift
//  OpenWeather
//
//  Created by Yang Yang on 19/2/22.
//

import Foundation

extension Date {
    
    func inSameDayAs(date: Date = Date(), calendar: Calendar = Calendar.current) -> Bool {
        return calendar.isDate(self, inSameDayAs: date)
    }
    
    func toYMDDateStr() -> String {
        let formatter = DateFormatter.ymdFormatter
        return formatter.string(from: self)
    }
    
}
