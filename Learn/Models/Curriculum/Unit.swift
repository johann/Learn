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
}
