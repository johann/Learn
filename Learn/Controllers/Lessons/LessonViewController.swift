//
//  LessonViewController.swift
//  Learn
//
//  Created by Johann Kerr on 4/25/19.
//  Copyright © 2019 Johann Kerr. All rights reserved.
//

import UIKit
import Down

class LessonViewController: UIViewController {
    @IBOutlet weak var navigationBar: UINavigationBar!
    
    var lesson: Lesson?
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.title = self.lesson?.title
        displayReadme()
    }
    
    func displayReadme() {
        let frame = CGRect(x: 0, y: 0, width: self.view.frame.width, height: self.view.frame.height)
        
        if let lesson = self.lesson {
            do {
                let markDownView = try DownView(frame: frame, markdownString: lesson.readme)
                self.view.addSubview(markDownView)
            } catch {
                
            }
            
        }
    }
    
    func configureLesson(_ lesson: Lesson) {
        self.lesson = lesson
    }
}
