//
//  LearnApi.swift
//  Learn
//
//  Created by Johann Kerr on 7/18/18.
//  Copyright © 2018 Johann Kerr. All rights reserved.
//

import Alamofire

struct LearnApi {
    static func getProfile(completion: @escaping (Student) -> ()) {
        let headers: HTTPHeaders = [
            "Authorization": "Bearer be6fd5e3d25ef654e1dcc630d1f2f6e7bcbea59e5a3c0899b447bc631c90cad2",
            "Content-Type": "application/json",
            "Accept": "version=1"
        ]
        
        Alamofire.request("\(Constants.localLearnAPI)/api/profiles/me", headers: headers).responseData { (res) in
            if let data = res.data {
                let decoder = JSONDecoder()
                decoder.keyDecodingStrategy = .convertFromSnakeCase
                
                let student = try! decoder.decode(Student.self, from: data)
                
                completion(student)
            }
        }
    }
    
    static func getCanonicalProgress(batch: String , track: String, completion: @escaping (Student) -> ()) {
    
        let headers: HTTPHeaders = [
            "Authorization": "Bearer 27c136770c55d8e66f4aff9fdb4e879abdab6385b4ce035ca004906baf74f1fb",
            "Content-Type": "application/json",
            "Accept": "version=1"
        ]
        
        Alamofire.request("\(Constants.learnAPI)/api/batches/\(batch)/tracks/\(track)", headers: headers).responseData { (res) in
            
            if let data = res.data {
                let decoder = JSONDecoder()
                decoder.keyDecodingStrategy = .convertFromSnakeCase
                
                let value = try! decoder.decode(StudentDataTransformer.self, from: data)
                if let student = value.students.filter({ (student) -> Bool in
                    student.id == 156928 // some random student
                }).first {
                    completion(student)
                }
            }
            
        }
    }
}

