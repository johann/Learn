//
//  UserDataStore.swift
//  Learn
//
//  Created by Johann Kerr on 7/20/18.
//  Copyright © 2018 Johann Kerr. All rights reserved.
//

import Foundation
import CoreData


final class UserDataStore {
    static let shared = UserDataStore()
    var student: Student?
    
    fileprivate init() {}
    func fetchProfile(completion: @escaping (Student) -> ()) {
        LearnApi.getProfile() { (student) in
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
    
    // MARK: Persistence Layer
    
    private lazy var persistentContainer: NSPersistentContainer = {
        let container = NSPersistentContainer(name: "Learn")
        container.loadPersistentStores(completionHandler: { (storeDescription, error) in
            if let error = error as NSError? {
                fatalError("Unresolved error \(error), \(error.userInfo)")
            }
        })
        return container
    }()
    
    private func saveContext () {
        let context = persistentContainer.viewContext
        if context.hasChanges {
            do {
                try context.save()
            } catch {
                let nserror = error as NSError
                fatalError("Unresolved error \(nserror), \(nserror.userInfo)")
            }
        }
    }
    
    
}
