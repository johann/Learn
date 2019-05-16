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
        profileVC.tabBarItem = UITabBarItem(title: "Profile", image: UIImage(named: "literature"), tag: 0)
        profileVC.coordinator = self
        
        navigationController.viewControllers = [profileVC]
    }
    
    
//    func showTopic(_ topic: Topic) {
//        let unitVC = UnitsViewController.instantiate()
//        guard let units = topic.units else { return }
//        unitVC.coordinator = self
//        unitVC.title = topic.title
//        unitVC.configureUnits(units)
//        self.navigationController.pushViewController(unitVC, animated: true)
//    }
//
//    func showLessonView(_ lesson: Lesson) {
//        let lessonVC = LessonViewController.instantiate()
//        lessonVC.configureLesson(lesson)
//        self.navigationController.pushViewController(lessonVC, animated: true)
//    }
}


