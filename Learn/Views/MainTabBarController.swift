//
//  MainTabBarController.swift
//  Learn
//
//  Created by Johann Kerr on 5/8/19.
//  Copyright © 2019 Johann Kerr. All rights reserved.
//
import UIKit


class MainTabBarController: UITabBarController, Storyboardable {
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.tabBar.tintColor = UIColor.black
        
        let vc = UIViewController()
        vc.view.backgroundColor = UIColor.red
        let uiNav = UINavigationController(rootViewController: vc)

        viewControllers = [uiNav]
    }
}
