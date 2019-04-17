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
    var topics: [Topic] = []

    override func viewDidLoad() {
        super.viewDidLoad()
        
        if let _ = store.student {
            store.fetchCurriculum { (track) in
                self.updateViewWith(track)
            }
        } else {
            store.fetchProfile { (_) in
                self.store.fetchCurriculum { (track) in
                    self.updateViewWith(track)
                }
            }
        }
    }
    
    // MARK: Update Track Info
    func updateViewWith(_ track: Track) {
        guard let topics = track.topics else { return }
        self.topics = topics
    }

    // MARK: - Navigation

    // MARK: UICollectionViewDataSource
    override func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return self.topics.count
    }

    override func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "topicCell", for: indexPath)
    
        cell.backgroundColor = UIColor.random
        return cell
    }

    // MARK: UICollectionViewDelegate
}
