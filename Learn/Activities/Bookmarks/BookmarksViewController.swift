//
//  BookmarksViewController.swift
//  Learn
//
//  Created by Luke Ghenco on 5/16/19.
//  Copyright © 2019 Johann Kerr. All rights reserved.
//

import UIKit

class BookmarksViewController: UIViewController, Storyboardable {
    
    @IBOutlet weak var tableView: UITableView!
    var coordinator: BookmarksCoordinator?
    let store = UserDataStore.shared
    var lessons: [Lesson] = []
    
    
    override func viewDidLoad() {
        self.title = "Bookmarks"
        guard let track = store.track else { return }
        self.lessons = track.randomLessons
        self.tableView.reloadData()
        self.tableView.dataSource = self
        self.tableView.delegate = self
        tableView.tableFooterView = UIView()
      
    }
}


extension BookmarksViewController: UITableViewDataSource {
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "bookMarkCell", for: indexPath)
        let lesson = lessons[indexPath.row]
        cell.textLabel?.text = lesson.title
        cell.detailTextLabel!.text = lesson.description
        return cell
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return self.lessons.count
    }
}

extension BookmarksViewController: UITableViewDelegate {
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        let lesson = self.lessons[indexPath.row]
        self.coordinator?.showLessonView(lesson)
    }
}
