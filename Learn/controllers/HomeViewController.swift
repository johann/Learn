//
//  ViewController.swift
//  Learn
//
//  Created by Johann Kerr on 7/15/18.
//  Copyright © 2018 Johann Kerr. All rights reserved.
//

import UIKit
import OAuthSwift
import Kingfisher

class HomeViewController: UIViewController {
    @IBOutlet weak var profileImageView: UIImageView!
    @IBOutlet weak var completionLabel: UILabel!
    @IBOutlet weak var velocityLabel: UILabel!
    @IBOutlet weak var nameLabel: UILabel!
    
    let store = UserDataStore.shared

    override func viewDidLoad() {
        super.viewDidLoad()
        
        store.fetchProfile { (student) in
            self.updateViewWith(student)
        }
      
        // Do any additional setup after loading the view, typically from a nib.
    }
    
    func updateViewWith(_ student: Student) {
        DispatchQueue.main.async {
            self.nameLabel.text = student.displayName
            self.velocityLabel.text = "\(student.velocity)"
            self.completionLabel.text = "\(student.completedLessonsCount)/\(student.totalLessonsCount)"
            if let gravatarURL = student.gravatarUrl, let url = URL(string: gravatarURL) {
                self.profileImageView.kf.setImage(with: url)
            }
        }
    }
    
}

