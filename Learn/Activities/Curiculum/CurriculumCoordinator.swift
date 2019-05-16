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

    
        let topicVC = TopicViewController.instantiate()
        topicVC.tabBarItem = UITabBarItem(title: "Home", image: UIImage(named: "literature"), tag: 0)
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
        let closeBtn = UIBarButtonItem(image: UIImage(named: "close_icon"), style: .plain, target: self, action: #selector(close))
        let saveBtn = UIBarButtonItem(image: UIImage(named: "bookmark_saved"), style: .plain, target: self, action: #selector(save))
        navigationController.navigationBar.tintColor = UIColor.black
        
        lessonVC.navigationItem.leftBarButtonItem = closeBtn
        lessonVC.navigationItem.rightBarButtonItem = saveBtn

        self.navigationController.present(navigationController, animated: true, completion: nil)
    }
    
    @objc func save() {
        
    }
    
    @objc func close() {
        self.navigationController.dismiss(animated: true, completion: nil)
    }
}

extension CurriculumCoordinator: LessonDelegate {
    func selectLesson(_ lesson: Lesson) {
        showLessonView(lesson)
    }
}

