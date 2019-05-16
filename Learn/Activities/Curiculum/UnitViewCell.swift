//
//  TableViewCell.swift
//  Learn
//
//  Created by Johann Kerr on 5/15/19.
//  Copyright © 2019 Johann Kerr. All rights reserved.
//

import UIKit

class UnitViewCell: UITableViewCell, Identifiable {
    lazy var flowlayout: UICollectionViewFlowLayout = {
        let l = UICollectionViewFlowLayout()
    
        l.scrollDirection = .horizontal
        let spacing = CGFloat(10.0)
        l.itemSize = CGSize(width: self.frame.width, height: 180)

        return l
    }()
    
    lazy var collectionView: UICollectionView = {
        let cv = UICollectionView(frame: CGRect(x: 0, y: 0, width: self.frame.width + 60, height: 200), collectionViewLayout: flowlayout)
        cv.register(LessonCell.self, forCellWithReuseIdentifier: LessonCell.identifier())
        cv.delegate = self
        cv.dataSource = self
        cv.backgroundColor = UIColor.purple
        return cv
    }()
    
    
    var lessons: [Lesson] = []
    
    override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        self.backgroundColor = UIColor.yellow
        self.addSubview(self.collectionView)

    }
    
    required init?(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)
    }
    
    
    func configureCell(_ unit: Unit) {
        if let lessons = unit.lessons {
            self.lessons = lessons
        }
    }
}

extension UnitViewCell: UICollectionViewDelegate {}
extension UnitViewCell: UICollectionViewDataSource {
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return lessons.count
    }
    
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        guard let cell = collectionView.dequeueReusableCell(withReuseIdentifier: LessonCell.identifier(), for: indexPath) as? LessonCell else { return UICollectionViewCell(frame: .zero)}
        
        let lesson = lessons[indexPath.row]
        cell.configureLesson(lesson)
        return cell
    }
}



class ProgrammaticCollectionViewCell: UICollectionViewCell {
    
    let titleLabel = UILabel()
    let mainView = UIView()
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        print("hello world")
        // subview config
        titleLabel.textAlignment = .left
        mainView.backgroundColor = UIColor.white
        mainView.layer.cornerRadius = 3
        
        // prepare subviews for layout
        contentView.addSubview(mainView)
        mainView.translatesAutoresizingMaskIntoConstraints = false
        mainView.addSubview(titleLabel)
        titleLabel.translatesAutoresizingMaskIntoConstraints = false
        mainView.layoutMargins = UIEdgeInsets(top: 10, left: 10, bottom: 10, right: 10)
        
        NSLayoutConstraint.activate([
            mainView.leadingAnchor.constraint(equalTo: contentView.leadingAnchor),
            mainView.topAnchor.constraint(equalTo: contentView.topAnchor),
            mainView.trailingAnchor.constraint(equalTo: contentView.trailingAnchor),
            mainView.bottomAnchor.constraint(equalTo: contentView.bottomAnchor),
            
            titleLabel.leadingAnchor.constraint(equalTo: mainView.layoutMarginsGuide.leadingAnchor),
            titleLabel.bottomAnchor.constraint(equalTo: mainView.layoutMarginsGuide.bottomAnchor)
            ])
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
}

