//
//  ProfileCoordinator.swift
//  Learn
//
//  Created by amay on 5/16/19.
//  Copyright © 2019 Johann Kerr. All rights reserved.
//

import UIKit

class ProfileCoordinator: Coordinator {
    var navigationController: UINavigationController
    
    init(navigationController: UINavigationController = .init()) {
        self.navigationController = navigationController
        self.navigationController.navigationBar.prefersLargeTitles = true
        
        let profileVC = ProfileViewController.instantiate()
        profileVC.tabBarItem = UITabBarItem(title: "Profile", image: UIImage(named: "profile-inactive"), tag: 0)
        profileVC.coordinator = self
        
        navigationController.viewControllers = [profileVC]
    }
}
