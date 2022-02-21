//
//  HTTPClient.swift
//  OpenWeather
//
//  Created by Yang Yang on 19/2/22.
//

import Combine
import Foundation

enum NetworkError: Error {
    case decodeFail(Error)
    case unknown(Error?)
}

protocol HTTPClientType {
    func requestObject<Object: Decodable>(from url: URL?, using api: API) -> AnyPublisher<Object, NetworkError>
}

struct HTTPClient: HTTPClientType {
    private let session: URLSession
    
    public init(session: URLSession = URLSession.shared) {
        self.session = session
    }
    
    func requestObject<Object: Decodable>(from url: URL? = nil, using api: API) -> AnyPublisher<Object, NetworkError> {

        session.dataTaskPublisher(for: request(from: url, using: api))
            .print("************* API REQUEST *************", to: nil)
            .tryMap { response in
                guard let httpURLResponse = response.response as? HTTPURLResponse, httpURLResponse.statusCode == 200 else {
                          throw NetworkError.unknown(nil)
                      }
                return response.data
            }
            .decode(type: Object.self, decoder: JSONDecoder())
            .mapError(NetworkError.decodeFail)
            .print("************* API RESPONSE *************", to: nil)
            .receive(on: DispatchQueue.main)
            .eraseToAnyPublisher()
    }
    
    private func request(from url: URL? = nil, using api: API) -> URLRequest {
        var components: URLComponents
        if let url = url {
            components = URLComponents(string: url.absoluteString + api.path)!
        } else {
            components = URLComponents(string: api.path)!
        }
        
        components.queryItems = api.parameters?.map { (key, value) in
            URLQueryItem(name: key, value: value)
        }
        components.percentEncodedQuery = components.percentEncodedQuery?.replacingOccurrences(of: "+", with: "%2B")
        
        var request = URLRequest(url: components.url!)
        request.httpMethod = api.method.rawValue
        request.allHTTPHeaderFields = api.header
        
        return request
    }
}
