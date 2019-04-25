//
//  Curriculum.swift
//  Learn
//
//  Created by Johann Kerr on 4/24/19.
//  Copyright © 2019 Johann Kerr. All rights reserved.
//

import Foundation

protocol Curriculum {
    var id: Int { get set }
    var slug: String { get set }
    var title: String { get set }
}
