//
//  ViewController.swift
//  Learn
//
//  Created by Johann Kerr on 5/15/19.
//  Copyright © 2019 Johann Kerr. All rights reserved.
//

import UIKit
import BTNavigationDropdownMenu

class ViewController: CollapsibleTableSectionViewController, Storyboardable {
    let store = UserDataStore.shared
    var track: Track?
    var menuItems: [String] = ["Food", "Beef"]
    var units: [Unit]?
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.tableview.register(TableViewCell.self, forCellReuseIdentifier: "tableCell")
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
        
        
        let firstTopic = topics[0]
        let number = Int.random(in: 0 ..< topics.)
        if let units = firstTopic.units {
            self.units = units
            self.tableview.reloadData()
        }
        
        
        let menuView = BTNavigationDropdownMenu(navigationController: self.navigationController, containerView: self.navigationController!.view, title: BTTitle.title(firstTopic.title), items: topicTitles)
        menuView.cellHeight = 50
        menuView.cellBackgroundColor = self.navigationController?.navigationBar.barTintColor
        menuView.didSelectItemAtIndexHandler = {(indexPath: Int) -> Void in
            print("Did select item at index: \(indexPath)")
            let topic = topics[indexPath]
            self.selectTopic(topic: topic)
            self.units = topic.units
            
        }
        menuView.arrowPadding = 15
        menuView.animationDuration = 0.5
        menuView.maskBackgroundColor = UIColor.black
        menuView.maskBackgroundOpacity = 0.3
        self.navigationItem.titleView = menuView
    }
    
    func handleMenuSelect(index: Int) {
        
    }
    
    
    func selectTopic(topic: Topic) {
        self.units = topic.units
        self.tableview.reloadData()
    }
}


// MARK: COllapsibleTableSectionDelegate
extension ViewController: CollapsibleTableSectionDelegate {
    func collapsibleTableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        guard let units = self.units else { return 0 }
        let unit = units[section]
        guard let lessons = unit.lessons else { return 0 }
        
        
        return lessons.count
    }
    
    func collapsibleTableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        guard let cell: TableViewCell = tableView.dequeueReusableCell(withIdentifier: "tableCell") as? TableViewCell else { return TableViewCell(style: .default, reuseIdentifier: "tableCell")}
        
        
        if let track = self.store.track, let topics = track.topics {
            let topic = topics[indexPath.section]
            cell.configureCell(topic)
            
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
     
        return unit.title
    }
}

// TODO: Rename to UnitViewCell

class TableViewCell: UITableViewCell {
    lazy var flowlayout: UICollectionViewFlowLayout = {
        let l = UICollectionViewFlowLayout()
        l.scrollDirection = .horizontal
        // needs size
        return l
    }()
    
    lazy var collectionView: UICollectionView = {
        let cv = UICollectionView(frame: .zero, collectionViewLayout: flowlayout)
        cv.delegate = self
        cv.dataSource = self
        return cv
    }()
    
    
    override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        self.contentView.backgroundColor = UIColor.green
    }
    
    required init?(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)
    }
    
    
    func configureCell(_ topic: Topic) {
  
    }
}

extension TableViewCell: UICollectionViewDelegate {}
extension TableViewCell: UICollectionViewDataSource {
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return 0
    }
    
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "collectionCell", for: indexPath)
        return cell
    }
}

