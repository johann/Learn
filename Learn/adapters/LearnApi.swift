//
//  LearnApi.swift
//  Learn
//
//  Created by Johann Kerr on 7/18/18.
//  Copyright © 2018 Johann Kerr. All rights reserved.
//

//import Alamofire
import Foundation


enum NetworkError: Error {
    case urlFailure
    case missingData
    case jsonError
}

class WebService {
    func request(_ endPoint: Endpoint, headers: [String: String], method: String = "GET", result: @escaping (Result<Data, Error>) -> Void) {
        guard let url = endPoint.url() else {  result(.failure(NetworkError.urlFailure)); return }
        var request = URLRequest(url: url)
        request.httpMethod = method
        for (header, headerValue) in headers {
            request.addValue(headerValue, forHTTPHeaderField: header)
        }
        URLSession.shared.dataTask(with: url) { (data, response, error) in
            if let error = error {
                result(.failure(error))
                return
            }
            guard let data = data else { result(.failure(NetworkError.missingData)); return }
            result(.success(data))
        }.resume()
    }
}

struct LearnApi {
    var service: WebService

    init(_ service: WebService = .init()) { self.service = service }
    
    func headersWithToken(_ token: String) -> [String: String] {
        return [
            "Authorization": "Bearer \(token)",
            "Content-Type": "application/json",
            "Accept": "version=1"
        ]
    }
    
    func getProfile(_ token: String, completion: @escaping (Result<Student, Error>) -> ()) {
        
        let headers = headersWithToken(token)
        
        service.request(.profile, headers: headers) { (result) in
            switch result {
            case .success(let data):
                break
            case .failure(let error):
                break
            }
        }
        
//        // TODO: Remove Alamofire
//        Alamofire.request("\(Constants.qaLearnAPI)/api/profiles/me", headers: headers).responseJSON { (res) in
//            if let data = res.data {
//                let decoder = JSONDecoder()
//                decoder.keyDecodingStrategy = .convertFromSnakeCase
//
//                // TODO: Remove try!
//                let student = try! decoder.decode(Student.self, from: data)
//
//                completion(student)
//            }
//        }
    }
}

