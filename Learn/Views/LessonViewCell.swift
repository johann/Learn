//
//  LessonViewCell.swift
//  Learn
//
//  Created by Johann Kerr on 4/13/19.
//  Copyright © 2019 Johann Kerr. All rights reserved.
//

import UIKit

class LessonViewCell: UICollectionViewCell {
    @IBOutlet weak var titleLabel: UILabel!
    override func awakeFromNib() {
        super.awakeFromNib()
    }
    
    required init?(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)
    }
    
    func configureCell(_ lesson: Lesson) {
        self.titleLabel.text = lesson.title
    }
    
}
