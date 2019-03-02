//
//  LearnApi.swift
//  Learn
//
//  Created by Johann Kerr on 7/18/18.
//  Copyright © 2018 Johann Kerr. All rights reserved.
//

import Alamofire

struct LearnApi {
  typealias Headers = [String:String]
  static let learnUrl = "https://15281336.ngrok.io/api/"
//  static let learnUrl = "https://learn.co/api/lessons/"
  
  static func currentLessonPath(_ userId: Int) -> String {
    return "users/\(userId)/current_lesson"
  }
  
  static func fetchCurrentLesson(token: String, userId: Int, completion: @escaping (Lesson?) -> ()) {
    let url = "\(learnUrl)/\(currentLessonPath(userId))"
    Alamofire.request(url, headers: headers()).responseData { (res) in
      if let data = res.data {
        let decoder = JSONDecoder()
//        decoder.keyDecodingStrategy = .convertFromSnakeCase
        
        do {
          let lesson = try decoder.decode(Lesson.self, from: data)
          completion(lesson)
        } catch {
          completion(nil)
        }
        
        
      }
    }
  }
  
  
  static func fetchLesson(token: String, lessonId: Int, completion: @escaping (String) -> ()) {
    let headers: HTTPHeaders = [
      "Authorization": "Bearer \(token)",
      "Content-Type": "application/json",
      "Accept": "version=1"
      
    ]
    
    Alamofire.request("\(learnUrl)/lessons/\(lessonId)", headers: headers).responseData { (res) in
      
      if let data = res.data {
        if let jsonObj = try! JSONSerialization.jsonObject(with: data, options: []) as? [String: Any] {
          print(jsonObj)
          if let lessonObj = jsonObj["lesson"] as? [String: Any] {
            let title = lessonObj["title"] as! String
            completion(title)
          }
        }
        
      }
      
    }
  }
  
  static func fetchStudent(token: String, completion: @escaping (Student) -> ()) {
    let headers: HTTPHeaders = [
      "Authorization": "Bearer \(token)",
      "Content-Type": "application/json",
      "Accept": "version=1"
      
    ]
    
    
    Alamofire.request("\(learnUrl)/api/users/me", headers: headers).responseData { (res) in
      
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
    
    Alamofire.request("\(learnUrl)/batches/\(batch)/tracks/\(track)", headers: headers).responseData { (res) in
      
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
  
  
  static func headers() -> Headers {
    return [
      "Authorization": "Bearer 27c136770c55d8e66f4aff9fdb4e879abdab6385b4ce035ca004906baf74f1fb",
      "Content-Type": "application/json",
      "Accept": "version=1"
    ]
  }
}

