//
//  TableViewCell.swift
//  Learn
//
//  Created by Johann Kerr on 5/15/19.
//  Copyright © 2019 Johann Kerr. All rights reserved.
//

import UIKit

class UnitViewCell: UITableViewCell, Identifiable {
    var containerFrame = 0.0
    var lessonDelegate: LessonDelegate?
    lazy var flowlayout: UICollectionViewFlowLayout = {
        let layout = UICollectionViewFlowLayout()
        layout.scrollDirection = .horizontal
        layout.itemSize = CGSize(width: self.frame.width, height: 180)
        return layout
    }()
    
    lazy var collectionView: UICollectionView = {
        let cv = UICollectionView(frame: CGRect(x: 0, y: 0, width: self.containerFrame, height: 200), collectionViewLayout: flowlayout)
        cv.backgroundColor = UIColor.white
        cv.register(LessonCell.self, forCellWithReuseIdentifier: LessonCell.identifier())
        cv.showsHorizontalScrollIndicator = false
        cv.delegate = self
        cv.dataSource = self
        return cv
    }()
    
    
    var lessons: [Lesson] = [] {
        didSet {

        }
    }
    
    override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        self.backgroundColor = UIColor.yellow
        

    }
    
    required init?(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)
    }
    
    
    func configureCell(_ unit: Unit) {
        if let lessons = unit.lessons {
            self.lessons = lessons
        }
        self.addSubview(self.collectionView)
    }
}

extension UnitViewCell: UICollectionViewDelegate {
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        let lesson = self.lessons[indexPath.row]
        lessonDelegate?.selectLesson(lesson)
    }
}
extension UnitViewCell: UICollectionViewDataSource {
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return lessons.count
    }
    
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        guard let cell = collectionView.dequeueReusableCell(withReuseIdentifier: LessonCell.identifier(), for: indexPath) as? LessonCell else { return UICollectionViewCell(frame: .zero)}
        
        let lesson = lessons[indexPath.row]
        cell.configureLesson(lesson)
        return cell
    }
}

