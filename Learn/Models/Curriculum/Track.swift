//
//  Track.swift
//  Learn
//
//  Created by Luke Ghenco on 4/17/19.
//  Copyright © 2019 Johann Kerr. All rights reserved.
//

import Foundation

struct Track: Curriculum, Codable {
    var id: Int
    var slug: String
    var title: String
    var topics: [Topic]?
    
    
    var lessons: [Lesson] {
        get {
            guard let topics = self.topics else { return [] }

            let units = topics.compactMap { (topic) -> [Unit]? in
                guard let units = topic.units else { return nil }
                
                return units
            }.joined()
            
            let lessons = units.compactMap { (unit) -> [Lesson]? in
                guard let lessons = unit.lessons else { return nil }
                
                return lessons
            }.joined()
            
            
            return lessons.map { (lesson) in lesson }
        }
    }
}
