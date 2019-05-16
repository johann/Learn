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

        let topicVC = TopicViewController.instantiate()
        topicVC.tabBarItem = UITabBarItem(title: "Lessons", image: UIImage(named: "lessons-inactive"), tag: 0)
        topicVC.coordinator = self

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
        let navigationController = UINavigationController()
        navigationController.viewControllers = [lessonVC]
        self.navigationController.present(navigationController, animated: true, completion: nil)
    }
}

extension CurriculumCoordinator: LessonDelegate {
    func selectLesson(_ lesson: Lesson) {
        showLessonView(lesson)
    }
}

