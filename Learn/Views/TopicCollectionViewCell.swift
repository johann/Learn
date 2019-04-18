//
//  TopicCollectionViewCell.swift
//  Learn
//
//  Created by Luke Ghenco on 4/17/19.
//  Copyright © 2019 Johann Kerr. All rights reserved.
//

import UIKit

class TopicCollectionViewCell: UICollectionViewCell {
    @IBOutlet weak var topicTitleField: UILabel!
    
    
    func configureCell(_ topic: Topic) {
        self.topicTitleField.text = topic.title
    }
}
