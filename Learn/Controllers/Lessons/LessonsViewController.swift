//
//  LessonsViewController.swift
//  Learn
//
//  Created by Johann Kerr on 7/20/18.
//  Copyright © 2018 Johann Kerr. All rights reserved.
//

import UIKit

class LessonsViewController: UICollectionViewController {

    override func viewDidLoad() {
        super.viewDidLoad()

        setupCollectionViewLayout()
    }
    
    func setupCollectionViewLayout() {
        guard let layout = collectionViewLayout as? UICollectionViewFlowLayout else { return }
        layout.sectionHeadersPinToVisibleBounds = true
        layout.itemSize = CGSize(width: collectionView.frame.width, height: 100)
        layout.minimumLineSpacing = 2
    }


}

extension LessonsViewController {
    override func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return 2
    }
    
    
    override func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "lessonCollectionCell", for: indexPath)
        cell.backgroundColor = UIColor.random
        return cell
    }
}
