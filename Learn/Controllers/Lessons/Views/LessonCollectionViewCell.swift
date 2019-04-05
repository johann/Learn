//
//  LessonCollectionViewCell.swift
//  Learn
//
//  Created by Johann Kerr on 4/5/19.
//  Copyright © 2019 Johann Kerr. All rights reserved.
//

import UIKit

class LessonCollectionViewCell: UICollectionViewCell {
    
    lazy var collectionView: UICollectionView = {
        var layout = UICollectionViewFlowLayout()
        layout.scrollDirection = .horizontal
        layout.sectionHeadersPinToVisibleBounds = true
        layout.itemSize = CGSize(width: 80, height: self.contentView.frame.height - 20)
        
        let collectionView = UICollectionView(frame: .zero, collectionViewLayout: layout)
        collectionView.translatesAutoresizingMaskIntoConstraints = false
        self.contentView.addSubview(collectionView)
        
        return collectionView
    }()
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        
        collectionView.backgroundColor = UIColor.random
        
        collectionView.delegate = self
        collectionView.dataSource = self
        collectionView.register(LessonCell.self, forCellWithReuseIdentifier: "lessonCell")
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError()
    }
    
}


extension LessonCollectionViewCell: UICollectionViewDelegate, UICollectionViewDataSource {
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return 2
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "lessonCell", for: indexPath)
        cell.backgroundColor = UIColor.random
        return cell
    }
    
    
}



class LessonCell: UICollectionViewCell {
    override init(frame: CGRect) {
        super.init(frame: frame)
        
        
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError()
    }
}
