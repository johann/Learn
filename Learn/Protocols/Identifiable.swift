//
//  Identifiable.swift
//  Learn
//
//  Created by Johann Kerr on 5/16/19.
//  Copyright © 2019 Johann Kerr. All rights reserved.
//
import UIKit
protocol Identifiable { }

extension Identifiable where Self: UIView {
    static func identifier() -> String {
        return String(describing: self)
    }
}
