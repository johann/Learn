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
        let bgColor = LearnColor.allCases.randomElement() ?? LearnColor.navyDark
            
        self.topicTitleField.text = topic.title
        self.backgroundColor = bgColor.value
    }
}
