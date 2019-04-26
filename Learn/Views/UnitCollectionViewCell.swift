//
//  UnitCollectionViewCell.swift
//  Learn
//
//  Created by Johann Kerr on 4/24/19.
//  Copyright © 2019 Johann Kerr. All rights reserved.
//

import UIKit

class UnitCollectionViewCell: UICollectionViewCell {
    @IBOutlet weak var collectionView: UICollectionView!
    @IBOutlet weak var titleLabel: UILabel!
    var lessons = [Lesson]()
    
    override func awakeFromNib() {
        super.awakeFromNib()
        
        collectionView.delegate = self
        collectionView.dataSource = self
        
    }
    
    required init?(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)
    }
    
    func configureCell(_ unit: Unit) {
        guard let lessons = unit.lessons else { return }
        self.lessons = lessons
        self.titleLabel.text = unit.title
    }
    
}


extension UnitCollectionViewCell: UICollectionViewDelegate, UICollectionViewDataSource {
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return lessons.count
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        guard let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "lessonCell", for: indexPath) as? LessonViewCell else { return UICollectionViewCell(frame: .zero) }
        let lesson = self.lessons[indexPath.row]
        
        cell.configureCell(lesson)
        return cell
    }
    
    
}
