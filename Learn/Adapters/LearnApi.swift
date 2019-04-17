//
//  LearnApi.swift
//  Learn
//
//  Created by Johann Kerr on 7/18/18.
//  Copyright © 2018 Johann Kerr. All rights reserved.
//

import Foundation

enum NetworkError: Error {
    case urlFailure
    case missingData
    case malformedJSON
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
                var student: Student
                let decoder = JSONDecoder()
                decoder.keyDecodingStrategy = .convertFromSnakeCase

                do {
                    student = try decoder.decode(Student.self, from: data)
                } catch {
                    completion(.failure(NetworkError.malformedJSON))
                    break
                }

                completion(.success(student))
                break
            case .failure(let error):
                completion(.failure(error))
                break
            }
        }
    }
    
    func getCurriculum(_ token: String, userId: Int, batchId: Int, trackId: Int, completion: @escaping (Result<Track, Error>) -> ()) {
        let headers = headersWithToken(token)
        let url = Endpoint.curriculum(userId, batchId, trackId).url()
        // TODO fix this endpoint to stringify params
        print(url)
        
        service.request(.curriculum(userId, batchId, trackId), headers: headers) { (result) in
            switch result {
            case .success(let data):
                var track: Track
                let decoder = JSONDecoder()
                decoder.keyDecodingStrategy = .convertFromSnakeCase

                do {
                    print("\(String(decoding: data, as: UTF8.self))")
                    track = try decoder.decode(Track.self, from: data)
                } catch {
                    completion(.failure(NetworkError.malformedJSON))
                    break
                }

                completion(.success(track))
                break

            case .failure(let error):
                completion(.failure(error))
                break
            }
        }
    }
}
