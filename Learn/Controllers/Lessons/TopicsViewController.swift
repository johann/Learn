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
    
    // MARK: Update Track Info
    func reloadView() {
        DispatchQueue.main.async {
            self.collectionView.reloadSections(IndexSet(integer: 0))
        }
    }

    // MARK: - Navigation

    // MARK: UICollectionViewDataSource
    override func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        guard let track = self.store.track else { return 0 }
        guard let topics = track.topics else { return 0 }
        
        return topics.count
    }

    override func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> TopicCollectionViewCell {
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "topicCell", for: indexPath) as! TopicCollectionViewCell
        
        guard let track = self.store.track else { return cell }
        guard let topics = track.topics else { return cell }
        
        let topic = topics[indexPath.row]
    
        cell.backgroundColor = UIColor.random
        cell.topicTitleField.text = topic.title
        return cell
    }

    // MARK: UICollectionViewDelegate
}
