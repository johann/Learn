//
//  Lesson.swift
//  Learn
//
//  Created by Johann Kerr on 10/23/18.
//  Copyright © 2018 Johann Kerr. All rights reserved.
//

import Foundation

struct Lesson: Codable {
  var title: String?
  var slug: String?
  var description: String?
  var readme: String?
  
  init() {
    self.title = ""
    self.slug = ""
    self.description = ""
    self.readme = ""
  }
}
