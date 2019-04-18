//
//  LessonViewCell.swift
//  Learn
//
//  Created by Johann Kerr on 4/13/19.
//  Copyright © 2019 Johann Kerr. All rights reserved.
//

import UIKit

class LessonViewCell: UICollectionViewCell {
    @IBOutlet weak var lessonView: UIView!
   
    override func awakeFromNib() {
        super.awakeFromNib()
        print("Lessom")
    }
    
    required init?(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)
        print("init")
    }
    
}
