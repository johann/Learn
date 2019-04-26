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
    
    
}

extension UnitsViewController {
    override func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return units.count
    }
    
    
    override func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        guard let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "unitCell", for: indexPath) as? UnitCollectionViewCell else { return UICollectionViewCell(frame: .zero) }
        let unit = self.units[indexPath.row]
        cell.configureCell(unit)
        return cell
    }
}
