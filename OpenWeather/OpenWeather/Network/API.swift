//
//  UpAPI.swift
//  OpenWeather
//
//  Created by Yang Yang on 19/2/22.
//

import Foundation

public typealias RequestHeader = [String: String]
public typealias RequestParameter = [String: String]

public enum RequestMethod: String {
    case get = "GET"
    case post = "POST"
    case put = "PUT"
    case delete = "DELETE"
}

protocol API {
    var path: String { get }
    var method: RequestMethod { get }
    var header: RequestHeader? { get }
    var parameters: RequestParameter? { get }
    var token: String? { get }
}

extension API {
    var header: RequestHeader? {
        var headers = [String: String]()
        headers["Content-Type"] = "application/json"
        return headers
    }

    var parameters: RequestParameter? {
        nil
    }

    var token: String? {
        nil
    }
}
