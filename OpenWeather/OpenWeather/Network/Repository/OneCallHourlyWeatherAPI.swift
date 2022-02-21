//
//  OneCallHourlyWeatherAPI.swift
//  OpenWeather
//
//  Created by Yang Yang on 19/2/22.
//

import Foundation

struct OneCallHourlyWeatherAPI: API {
    
    var path: String {
        return "/data/2.5/onecall"
    }

    var method: RequestMethod {
        return .get
    }

    var parameters: RequestParameter? 
}
