//
//  Lesson.swift
//  Learn
//
//  Created by Johann Kerr on 4/24/19.
//  Copyright © 2019 Johann Kerr. All rights reserved.
//

import Foundation

class Lesson: Curriculum, Codable, CustomStringConvertible {
    var id: Int
    var slug: String
    var title: String
    var readme: String
    var isComplete: Bool
    
    enum CodingKeys: String, CodingKey {
        case id = "id"
        case slug = "slug"
        case title = "title"
        case readme = "readme"
        case isComplete = "isComplete"
    }
    
    required public init(from decoder: Decoder) throws {
        let values = try decoder.container(keyedBy: CodingKeys.self)
        id = try values.decode(Int.self, forKey: .id)
        slug = try values.decode(String.self, forKey: .slug)
        title = try values.decode(String.self, forKey: .title)
        readme = try values.decode(String.self, forKey: .readme)
        isComplete = try values.decodeIfPresent(Bool.self, forKey: .isComplete) ?? false
    }
    
    func complete() {
        isComplete = true
    }
    
    var description: String {
        return "\(self.id) - \(self.slug) - \(self.title) - \(self.isComplete) "
    }
}


extension Lesson: Equatable {
    static func == (lhs: Lesson, rhs: Lesson) -> Bool {
        return lhs.slug == rhs.slug
    }
}
