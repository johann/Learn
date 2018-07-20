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
    
    fileprivate init() {}
    
    
    func fetchProgress(completion: @escaping (Student) -> ()) {
        LearnApi.getCanonicalProgress(batch: "597", track: "25054") { (student) in
            self.student = student
            completion(student)
        }
    }
    
    
}
