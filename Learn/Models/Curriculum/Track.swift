//
//  Track.swift
//  Learn
//
//  Created by Luke Ghenco on 4/17/19.
//  Copyright © 2019 Johann Kerr. All rights reserved.
//

import Foundation

protocol Curriculum {
    var id: Int { get set }
    var slug: String { get set }
    var title: String { get set }
}

struct Track: Curriculum, Codable {
    var id: Int
    var slug: String
    var title: String
    var topics: [Topic]?
}

struct Topic: Curriculum, Codable {
    var id: Int
    var slug: String
    var title: String
    var units: [Unit]?
}

struct Unit: Curriculum, Codable {
    var id: Int
    var slug: String
    var title: String
    var lessons: [Lesson]?
}

struct Lesson: Curriculum, Codable {
    var id: Int
    var slug: String
    var title: String
    var readme: String
}
