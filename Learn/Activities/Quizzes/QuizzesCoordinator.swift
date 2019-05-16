//
//  QuizzesCoordinator.swift
//  Learn
//
//  Created by Luke Ghenco on 5/16/19.
//  Copyright © 2019 Johann Kerr. All rights reserved.
//

import UIKit

class QuizzesCoordinator: Coordinator {
    var navigationController: UINavigationController
    
    init(navigationController: UINavigationController = .init()) {
        self.navigationController = navigationController
        self.navigationController.navigationBar.prefersLargeTitles = true
        
        let quizzesVC = QuizzesViewController.instantiate()
        quizzesVC.tabBarItem = UITabBarItem(title: "Quizzes", image: UIImage(named: "quizzes-inactive"), tag: 0)
        quizzesVC.coordinator = self
        
        navigationController.viewControllers = [quizzesVC]
    }
}
