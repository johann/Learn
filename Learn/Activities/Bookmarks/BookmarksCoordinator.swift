//
//  BookmarksCoordinator.swift
//  Learn
//
//  Created by Luke Ghenco on 5/16/19.
//  Copyright © 2019 Johann Kerr. All rights reserved.
//

import UIKit

class BookmarksCoordinator: Coordinator {
    var navigationController: UINavigationController
    
    init(navigationController: UINavigationController = .init()) {
        self.navigationController = navigationController
        self.navigationController.navigationBar.prefersLargeTitles = true
        
        let bookmarksVC = BookmarksViewController.instantiate()
        bookmarksVC.tabBarItem = UITabBarItem(title: "Bookmarks", image: UIImage(named: "bookmarks-inactive"), tag: 0)
        bookmarksVC.coordinator = self
        
        navigationController.viewControllers = [bookmarksVC]
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
