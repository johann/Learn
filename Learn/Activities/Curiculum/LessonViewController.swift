//
//  LessonViewController.swift
//  Learn
//
//  Created by Johann Kerr on 4/25/19.
//  Copyright © 2019 Johann Kerr. All rights reserved.
//

import UIKit
import Down

class LessonViewController: UIViewController, Storyboardable {
    var lesson: Lesson?
    var completeBtn = UIButton()
    var markDownView: DownView!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.title = self.lesson?.title
        displayReadme()
        setupButton()
    }
    
    func displayReadme() {
        guard let lesson = self.lesson else { return }
        do {
            markDownView = try DownView(frame: .zero, markdownString: lesson.readme)
            self.view.addSubview(markDownView!)
            markDownView.translatesAutoresizingMaskIntoConstraints = false
            
            NSLayoutConstraint.activate([
                markDownView.widthAnchor.constraint(equalTo: self.view.widthAnchor),
                markDownView.leftAnchor.constraint(equalTo: self.view.leftAnchor),
                markDownView.topAnchor.constraint(equalTo: self.view.topAnchor),
                markDownView.heightAnchor.constraint(equalTo: self.view.heightAnchor, multiplier: 0.92)
                ])
            
        } catch {
            
        }
    }
    
    func setupButton(){
        completeBtn.backgroundColor = LearnColor.blue.value
        completeBtn.setTitleColor(UIColor.white, for: .normal)
        completeBtn.setTitle("Mark as Completed", for: .normal)
        completeBtn.addTarget(self, action: #selector(markAsComplete), for: .touchUpInside)
        
        self.view.addSubview(completeBtn)
        completeBtn.translatesAutoresizingMaskIntoConstraints = false
        NSLayoutConstraint.activate([
            completeBtn.widthAnchor.constraint(equalTo: self.view.widthAnchor),
            completeBtn.topAnchor.constraint(equalTo: self.markDownView.bottomAnchor),
            completeBtn.leftAnchor.constraint(equalTo: self.view.leftAnchor),
            completeBtn.bottomAnchor.constraint(equalTo: self.view.bottomAnchor)
            ])
    }
    
    @objc func markAsComplete() {
        // save some things
        self.navigationController?.dismiss(animated: true, completion: nil)
    }
    
    func configureLesson(_ lesson: Lesson) {
        self.lesson = lesson
    }
}
