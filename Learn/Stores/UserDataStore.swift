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
        let trackId = student.activeTrack.id
        
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
