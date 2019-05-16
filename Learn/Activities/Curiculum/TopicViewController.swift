//
//  ViewController.swift
//  Learn
//
//  Created by Johann Kerr on 5/15/19.
//  Copyright © 2019 Johann Kerr. All rights reserved.
//

import UIKit
import BTNavigationDropdownMenu

class TopicViewController: CollapsibleTableSectionViewController, Storyboardable {
    let store = UserDataStore.shared
    var track: Track?
    var units: [Unit]?
    var coordinator: CurriculumCoordinator?
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.tableview.register(UnitViewCell.self, forCellReuseIdentifier: UnitViewCell.identifier())
        self.delegate = self
        
        if let _ = store.student {
            store.fetchCurriculum { (track) in
                self.track = track
                self.reloadView()
            }
        } else {
            store.fetchProfile { (_) in
                self.store.fetchCurriculum { (track) in
                    self.track = track
                    self.reloadView()
                }
            }
        }
    }

    
    func reloadView() {
        DispatchQueue.main.async {
            self.configureMenu()
        }
    }
    
    func configureMenu() {
        guard let track = self.store.track, let topics = track.topics else { return }
        let topicTitles = topics.map{ $0.title }
    
        let number = Int.random(in: 0 ..< topicTitles.count - 1)
        let topic = topics[number]
        if let units = topic.units {
            self.units = units
            self.tableview.reloadData()
        }
        
        let menuView = BTNavigationDropdownMenu(navigationController: self.navigationController, containerView: self.navigationController!.view, title: BTTitle.title(topic.title), items: topicTitles)
        menuView.cellHeight = 50
        menuView.cellBackgroundColor = self.navigationController?.navigationBar.barTintColor
        menuView.arrowTintColor = UIColor.black
        menuView.didSelectItemAtIndexHandler = {[weak self] (indexPath: Int) -> Void in
            let topic = topics[indexPath]
            self?.selectTopic(topic: topic)
            self?.units = topic.units
            
        }
        menuView.cellTextLabelAlignment = .left
        menuView.arrowPadding = 15
        menuView.animationDuration = 0.5
        menuView.maskBackgroundColor = UIColor.black
        menuView.maskBackgroundOpacity = 0.3
        self.navigationItem.titleView = menuView
    }
    
    func selectTopic(topic: Topic) {
        self.units = topic.units
        self.tableview.reloadData()
    }
}


// MARK: COllapsibleTableSectionDelegate
extension TopicViewController: CollapsibleTableSectionDelegate {
    func collapsibleTableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return 1
    }
    
    func collapsibleTableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        
        guard let cell: UnitViewCell = tableView.dequeueReusableCell(withIdentifier: UnitViewCell.identifier()) as? UnitViewCell else { return UnitViewCell(style: .default, reuseIdentifier: UnitViewCell.identifier())}
        
        cell.containerFrame = Double(self.view.frame.width)
        cell.lessonDelegate = self.coordinator
        if let units = self.units {
            let unit = units[indexPath.section]
            cell.configureCell(unit)
            
        }
        return cell
    }
    
    func numberOfSections(_ tableView: UITableView) -> Int {
        guard let units = self.units else { return 0 }
        return units.count
    }
    
    func shouldCollapseByDefault(_ tableView: UITableView) -> Bool {
        return true
    }
    
    func collapsibleTableView(_ tableView: UITableView, titleForHeaderInSection section: Int) -> String? {
        guard let units = self.units else { return "" }
        let unit = units[section]
        guard let lessons = unit.lessons else { return "" }
        return "\(unit.title) - (\(lessons.count))"
    }
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return 200.0
    }
}

// TODO: Rename to UnitViewCell


