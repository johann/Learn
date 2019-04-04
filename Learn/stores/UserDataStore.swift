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
        LearnApi.init().getProfile(token) { (response) in
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
}
