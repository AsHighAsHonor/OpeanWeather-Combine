//
//  String+Json.swift
//  OpenWeather
//
//  Created by Yang Yang on 19/2/22.
//

import Foundation

extension String {
    
    func readJSONFromFile() -> Data? {
        do {
            if let bundlePath = Bundle.main.path(forResource: self, ofType: "json"),
               let jsonData = try String(contentsOfFile: bundlePath).data(using: .utf8) {
                return jsonData
            }
        } catch {
            print(error)
        }
        
        return nil
    }
    
}

extension Data {
    
    func parse<T: Decodable>(type: T.Type) -> T? {
        do {
            let decodedData = try JSONDecoder().decode(T.self, from: self)
            return decodedData
        } catch {
            print("decode error")
        }
        return nil
    }
    
}
