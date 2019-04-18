//
//  LessonCollectionViewCell.swift
//  Learn
//
//  Created by Johann Kerr on 4/5/19.
//  Copyright © 2019 Johann Kerr. All rights reserved.
//

import UIKit

class LessonCollectionViewCell: UICollectionViewCell {
    
    @IBOutlet weak var collectionView: UICollectionView!
    
    override func awakeFromNib() {
        super.awakeFromNib()
        print("awakeFromNib", self.collectionView)
//        var layout = UICollectionViewFlowLayout()
//        layout.scrollDirection = .horizontal
//        layout.sectionHeadersPinToVisibleBounds = true
//        layout.itemSize = CGSize(width: 120, height: self.contentView.frame.height - 20)
//        self.collectionView.collectionViewLayout = layout
        
        collectionView.delegate = self
        collectionView.dataSource = self
        
    }
    
    required init?(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)
    }
}


extension LessonCollectionViewCell: UICollectionViewDelegate, UICollectionViewDataSource {
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return 6
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "lessonCell", for: indexPath) 
        return cell
    }
    
    
}
