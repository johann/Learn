//
//  CurriculumCoordinator.swift
//  Learn
//
//  Created by Johann Kerr on 5/8/19.
//  Copyright © 2019 Johann Kerr. All rights reserved.
//

import UIKit

class CurriculumCoordinator: Coordinator {
    var navigationController: UINavigationController

    init(navigationController: UINavigationController = .init()) {
        self.navigationController = navigationController
//        self.navigationController.navigationBar.prefersLargeTitles = true
        
//        let topicVC = TopicsViewController.instantiate()
//        topicVC.tabBarItem = UITabBarItem(title: "Home", image: UIImage(named: "literature"), tag: 0)
//        topicVC.coordinator = self
    
        let topicVC = TopicViewController.instantiate()
        topicVC.tabBarItem = UITabBarItem(title: "Home", image: UIImage(named: "literature"), tag: 0)
        
        navigationController.viewControllers = [topicVC]
    }
    
    
    func showTopic(_ topic: Topic) {
        let unitVC = UnitsViewController.instantiate()
        guard let units = topic.units else { return }
        unitVC.coordinator = self
        unitVC.title = topic.title
        unitVC.configureUnits(units)
        self.navigationController.pushViewController(unitVC, animated: true)
    }
    
    func showLessonView(_ lesson: Lesson) {
        let lessonVC = LessonViewController.instantiate()
        lessonVC.configureLesson(lesson)
        self.navigationController.pushViewController(lessonVC, animated: true)
    }
}

extension CurriculumCoordinator: LessonDelegate {
    func selectLesson(_ lesson: Lesson) {
        showLessonView(lesson)
    }
}

