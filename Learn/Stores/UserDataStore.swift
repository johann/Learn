//
//  UserDataStore.swift
//  Learn
//
//  Created by Johann Kerr on 7/20/18.
//  Copyright © 2018 Johann Kerr. All rights reserved.
//

import Foundation

final class UserDataStore {
    static let shared = UserDataStore()
    var student: Student?
    var track: Track?
    var token: String {
        guard let token = UserDefaults.standard.string(forKey: "token") else { fatalError("Token not found") }
        return token
    }
    
    fileprivate init() {}
    
    func fetchProfile(completion: @escaping (Student) -> ()) {
        LearnApi().getProfile(token) { (response) in
            switch response {
            case .success(let student):
                self.student = student
                completion(student)
                break
            case .failure(let error):
                print(error)
                break
            }
        }
    }
    
    func fetchCurriculum(completion: @escaping (Track) -> ()) {
        guard let student = self.student else { fatalError("Student is not defined") }
        let userId = student.id
        let batchId = student.activeBatch.id
//        let trackId = student.activeTrack.id
        let trackId = 45971
        
        LearnApi().getCurriculum(token, userId: userId, batchId: batchId, trackId: trackId) { (response) in
            switch response {
            case .success(let track):
                self.track = track
                completion(track)
                break
            case .failure(let error):
                print(error)
                break
            }
            
        }
    }
}
