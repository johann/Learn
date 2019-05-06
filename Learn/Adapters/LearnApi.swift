//
//  LearnApi.swift
//  Learn
//
//  Created by Johann Kerr on 7/18/18.
//  Copyright © 2018 Johann Kerr. All rights reserved.
//

import Foundation

struct LearnApi {
    var service: WebService
    var decoder: JSONDecoder

    init(_ service: WebService = .init(), _ decoder: JSONDecoder = .init()) {
        self.service = service
        self.decoder = decoder
        self.decoder.keyDecodingStrategy = .convertFromSnakeCase
    }
    
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
                do {
                    let student = try self.decoder.decode(Student.self, from: data)
                    completion(.success(student))
                } catch {
                    completion(.failure(NetworkError.malformedJSON))
                }
            case .failure(let error):
                completion(.failure(error))
            }
        }
    }
    
    func getCurriculum(_ token: String, userId: Int, batchId: Int, trackId: Int, completion: @escaping (Result<Track, Error>) -> ()) {
        service.request(.curriculum(userId, batchId, trackId), headers: headersWithToken(token)) { (result) in
            switch result {
            case .success(let data):
                do {
                    let track = try self.decoder.decode(Track.self, from: data)
                    LearnTrackCache().set(track, data: data)
                    completion(.success(track))
                } catch {
                    completion(.failure(NetworkError.malformedJSON))
                }
            case .failure(let error):
                completion(.failure(error))
            }
        }
    }
}
