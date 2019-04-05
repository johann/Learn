//
//  ColorHelper.swift
//  Learn
//
//  Created by Johann Kerr on 4/5/19.
//  Copyright © 2019 Johann Kerr. All rights reserved.
//
import UIKit
import Foundation

extension UIColor {
    static var random: UIColor {
        return UIColor(red: .random(in: 0...1),
                       green: .random(in: 0...1),
                       blue: .random(in: 0...1),
                       alpha: 1.0)
    }
}
