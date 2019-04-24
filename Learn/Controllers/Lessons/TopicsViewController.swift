//
//  TopicsViewController.swift
//  Learn
//
//  Created by Luke Ghenco on 4/17/19.
//  Copyright © 2019 Johann Kerr. All rights reserved.
//

import UIKit

class TopicsViewController: UICollectionViewController {
    let store = UserDataStore.shared

    override func viewDidLoad() {
        super.viewDidLoad()
        
        setupCollectionView()
        
        if let _ = store.student {
            store.fetchCurriculum { (track) in
                self.reloadView()
            }
        } else {
            store.fetchProfile { (_) in
                self.store.fetchCurriculum { (track) in
                    self.reloadView()
                }
            }
        }
    }
    
    func setupCollectionView() {
        guard let layout = collectionViewLayout as? UICollectionViewFlowLayout else { return }
        layout.sectionHeadersPinToVisibleBounds = true
        let padding: CGFloat = 10
        let collectionCellSize = collectionView.frame.size.width - padding
        layout.itemSize = CGSize(width: collectionCellSize/2, height: 100)
        layout.minimumLineSpacing = 2
    }
    
    func reloadView() {
        DispatchQueue.main.async {
            self.collectionView.reloadData()
        }
    }

    // MARK: UICollectionViewDataSource
    
    override func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        guard let track = self.store.track else { return 0 }
        guard let topics = track.topics else { return 0 }
        
        return topics.count
    }

    override func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        guard let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "topicCell", for: indexPath) as? TopicCollectionViewCell else { return UICollectionViewCell(frame: .zero) }
        
        if let track = self.store.track, let topics = track.topics {
            let topic = topics[indexPath.row]
            cell.configureCell(topic)
            
        }
        
        return cell
    }

}
