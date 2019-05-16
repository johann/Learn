//
//  Unit.swift
//  
//
//  Created by Johann Kerr on 4/24/19.
//

import Foundation

struct Unit: Curriculum, Codable {
    var id: Int
    var slug: String
    var title: String
    var lessons: [Lesson]?
    var isComplete: Bool {
        guard let lessons = lessons else { return true }
            
        if lessons.count == 0 { return false }
        
        for lesson in lessons {
            if !lesson.isComplete { return false }
        }
        
        return true
    }
    var completedLessonCount: Int {
        guard let lessons = lessons else { return 0 }
            
        return lessons.filter{ $0.isComplete }.count
    }
}
