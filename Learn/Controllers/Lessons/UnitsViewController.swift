//
//  TopicViewController.swift
//  Learn
//
//  Created by Johann Kerr on 4/24/19.
//  Copyright © 2019 Johann Kerr. All rights reserved.
//

import UIKit

class UnitsViewController: UICollectionViewController {
    var units = [Unit]()
    var selectedLesson: Lesson?
    
    override func viewDidLoad() {
        super.viewDidLoad()
        setupCollectionViewLayout()
    }
    
    func configureUnits(_ units: [Unit]) {
        self.units = units
    }
    
    
    func setupCollectionViewLayout() {
        guard let layout = self.collectionViewLayout as? UICollectionViewFlowLayout else { return }
        layout.sectionHeadersPinToVisibleBounds = true
        layout.itemSize = CGSize(width: collectionView.frame.width, height: 100)
        layout.minimumLineSpacing = 2
    }
    
    func showLessonView(lesson: Lesson) {
        let storyboard = UIStoryboard(name: "Main", bundle: nil)
        if let lessonVC = storyboard.instantiateViewController(withIdentifier: "lessonViewController") as? LessonViewController {
            lessonVC.lesson = lesson
            self.navigationController?.pushViewController(lessonVC, animated: true)
        }
        
    }

}


// MARK: CollectionViewDelegate & Datasource
extension UnitsViewController {
    override func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return units.count
    }
    
    
    override func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        guard let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "unitCell", for: indexPath) as? UnitCollectionViewCell else { return UICollectionViewCell(frame: .zero) }
        let unit = self.units[indexPath.row]
        cell.lessonDelegate = self
        cell.configureCell(unit)
        return cell
    }
}

// MARK: LessonDelegate
extension UnitsViewController: LessonDelegate {
    func selectLesson(_ lesson: Lesson) {
        showLessonView(lesson: lesson)
    }
}
