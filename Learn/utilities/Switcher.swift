//
//  Switcher.swift
//  Learn
//
//  Created by Johann Kerr on 7/20/18.
//  Copyright © 2018 Johann Kerr. All rights reserved.
//

import Foundation
import UIKit

class Switcher {

    static func updateVC() {
        var rootVC: UIViewController!
//        if loggedIn() {
            rootVC = UIStoryboard(name: "Main", bundle: nil).instantiateViewController(withIdentifier: "homeVC")
//        } else {
//             rootVC = UIStoryboard(name: "Main", bundle: nil).instantiateViewController(withIdentifier: "loginVC")
//        }
        let appDelegate = UIApplication.shared.delegate as! AppDelegate
        appDelegate.window?.rootViewController = rootVC
    }
    
    static func loggedIn() -> Bool {
        guard let token =  UserDefaults.standard.string(forKey: "token") else { return false }
        return true
    }
}
