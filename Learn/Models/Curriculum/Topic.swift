//
//  Topic.swift
//  Learn
//
//  Created by Johann Kerr on 4/24/19.
//  Copyright © 2019 Johann Kerr. All rights reserved.
//

import Foundation

class Topic: Curriculum, Codable {
    var id: Int
    var slug: String
    var title: String
    var units: [Unit]?
    var isComplete: Bool {
       return lessonCount == lessonCompletionCount
    }
    var lessonCount: Int {
        guard let units = units else { return 0 }
        
        return units.reduce(0, { acc, unit in
            let lessons = unit.lessons ?? []
            return acc + lessons.count
        })
    }
    var lessonCompletionCount: Int {
        guard let units = units else { return 0 }
        
        return units.reduce(0, { acc, unit in acc + unit.completedLessonCount })
    }
}
