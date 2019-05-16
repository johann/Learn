//
//  LessonCell.swift
//  Learn
//
//  Created by Johann Kerr on 5/15/19.
//  Copyright © 2019 Johann Kerr. All rights reserved.
//

import UIKit

protocol LessonComplete {
    func completeLesson(lesson: Lesson)
}

class LessonCell: UICollectionViewCell, Identifiable {
    
    var lessonLabel = UILabel()
    var lesson: Lesson? {
        didSet {
        }
    }
    

    override init(frame: CGRect) {
        super.init(frame: frame)
        self.addSubview(lessonLabel)
        self.lessonLabel.translatesAutoresizingMaskIntoConstraints = false
        self.lessonLabel.lineBreakMode = .byWordWrapping
        self.backgroundColor = LearnColor.random.value
        self.lessonLabel.textColor = UIColor.white
        self.lessonLabel.numberOfLines = 0
        NSLayoutConstraint.activate([
            lessonLabel.widthAnchor.constraint(equalTo: self.widthAnchor, constant: -20.0),
            lessonLabel.heightAnchor.constraint(equalToConstant: 50),
            lessonLabel.leftAnchor.constraint(equalTo: self.leftAnchor, constant: 10.0),
            lessonLabel.bottomAnchor.constraint(equalTo: self.bottomAnchor, constant: 10.0)
            ])
    }
    
    func configureLesson(_ lesson: Lesson) {
        self.lesson = lesson
        self.lessonLabel.text = lesson.title
    }
    
    required init?(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)
    }
}
