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
}
