//
//  Lesson.swift
//  Learn
//
//  Created by Johann Kerr on 4/24/19.
//  Copyright © 2019 Johann Kerr. All rights reserved.
//

import Foundation

struct Lesson: Curriculum, Codable, Equatable {
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
    
    public init(from decoder: Decoder) throws {
        let values = try decoder.container(keyedBy: CodingKeys.self)
        id = try values.decode(Int.self, forKey: .id)
        slug = try values.decode(String.self, forKey: .slug)
        title = try values.decode(String.self, forKey: .title)
        readme = try values.decode(String.self, forKey: .readme)
        isComplete = try values.decodeIfPresent(Bool.self, forKey: .isComplete) ?? false
    }
    
    mutating func complete() {
        isComplete = true
    }
}
