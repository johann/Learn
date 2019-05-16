//
//  MainTabBarController.swift
//  Learn
//
//  Created by Johann Kerr on 5/8/19.
//  Copyright © 2019 Johann Kerr. All rights reserved.
//
import UIKit


class MainTabBarController: UITabBarController, Storyboardable {
    let curriculum = CurriculumCoordinator()
    let profile = ProfileCoordinator()
    let bookmarks = BookmarksCoordinator()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.tabBar.tintColor = LearnColor.black.value
  
        viewControllers = [curriculum.navigationController, profile.navigationController, bookmarks.navigationController]
    }
}

