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
    var token: String {
        guard let token = UserDefaults.standard.string(forKey: "token") else { fatalError("Token not found") }
        return token
    }
    
    fileprivate init() {}
    
    
    func fetchProfile(completion: @escaping (Student) -> ()) {
        LearnApi.getProfile(token) { (student) in
            self.student = student
            completion(student)
        }
    }
    
    
    func fetchProgress(completion: @escaping (Student) -> ()) {
        LearnApi.getCanonicalProgress(batch: "597", track: "25054") { (student) in
            self.student = student
            completion(student)
        }
    }
    
    
}
