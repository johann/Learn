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
        let topicVC = TopicsViewController.instantiate()
        topicVC.coordinator = self
        
        navigationController.viewControllers = [topicVC]
    }
    
    
    func showTopic(_ topic: Topic) {
        let unitVC = UnitsViewController.instantiate()
        guard let units = topic.units else { return }
        unitVC.configureUnits(units)
        self.navigationController.pushViewController(unitVC, animated: true)
    }
}

