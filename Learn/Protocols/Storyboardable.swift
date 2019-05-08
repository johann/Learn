//
//  Storyboardable.swift
//  Learn
//
//  Created by Johann Kerr on 5/8/19.
//  Copyright © 2019 Johann Kerr. All rights reserved.
//

import UIKit
protocol Storyboardable { }

extension Storyboardable where Self: UIViewController {
    static func instantiate() -> Self {
        let storyboardIdentifier = String(describing: self)
        let storyboard = UIStoryboard(name: "Main", bundle: Bundle.main)
        
        return storyboard.instantiateViewController(withIdentifier: storyboardIdentifier) as! Self
    }
}
