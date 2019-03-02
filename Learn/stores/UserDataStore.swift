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
    return UserDefaults.standard.string(forKey: "token") ?? "1358ff6e1801d730d35b2b4f0781df20f02af0f24450b2d57e7344b2e8398564"
  }
  
  
  fileprivate init() {}
  
  func fetchCurrentLesson(completion: @escaping (Lesson?) -> ()) {
    // student?.id
    LearnApi.fetchCurrentLesson(token: token, userId: 37) { (lesson) in
      let lesson =  lesson ?? nil
      completion(lesson)
    }
  }
  
  
  func fetchStudent(completion: @escaping (Student) -> ()) {
    LearnApi.fetchStudent(token: token) { (student) in
      print(student)
      completion(student)
    }
  }
  
  func fetchLesson(lessonId: Int, completion: @escaping (String) -> ()) {
    LearnApi.fetchLesson(token: token, lessonId: lessonId) { (lessonTitle) in
      completion(lessonTitle)
    }
  }
  
  func fetchProgress(completion: @escaping (Student) -> ()) {
    LearnApi.getCanonicalProgress(batch: "597", track: "25054") { (student) in
      self.student = student
      completion(student)
    }
  }
  
  
}
