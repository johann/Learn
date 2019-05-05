//
//  WebService.swift
//  Learn
//
//  Created by Luke Ghenco on 5/5/19.
//  Copyright © 2019 Johann Kerr. All rights reserved.
//

import Foundation

class WebService {
    func request(_ endPoint: Endpoint, headers: [String: String], method: String = "GET", result: @escaping (Result<Data, Error>) -> Void) {
        
        guard let url = endPoint.url() else {  result(.failure(NetworkError.urlFailure)); return }
        var request = URLRequest(url: url)
        request.httpMethod = method
        for (header, headerValue) in headers {
            request.addValue(headerValue, forHTTPHeaderField: header)
        }
        URLSession.shared.dataTask(with: request) { (data, response, error) in
            if let error = error {
                result(.failure(error))
                return
            }
            guard let data = data else { result(.failure(NetworkError.missingData)); return }
            result(.success(data))
            }.resume()
    }
}
