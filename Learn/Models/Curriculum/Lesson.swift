//
//  Lesson.swift
//  Learn
//
//  Created by Johann Kerr on 4/24/19.
//  Copyright © 2019 Johann Kerr. All rights reserved.
//

import Foundation

struct Lesson: Curriculum, Codable {
    var id: Int
    var slug: String
    var title: String
    var readme: String
}
