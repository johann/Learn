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

//learn-auth://learn/callback


class HomeViewController: UIViewController {
    @IBOutlet weak var profileImageView: UIImageView!
    @IBOutlet weak var completionLabel: UILabel!
    @IBOutlet weak var velocityLabel: UILabel!
    @IBOutlet weak var nameLabel: UILabel!
    
    let store = UserDataStore.shared

    override func viewDidLoad() {
        super.viewDidLoad()
        
        store.fetchProgress { (studentWithProgress) in
            print(studentWithProgress)
            self.updateViewWith(studentWithProgress)
            
        }
      
        // Do any additional setup after loading the view, typically from a nib.
    }
    
    func updateViewWith(_ student: Student) {
        DispatchQueue.main.async {
            self.nameLabel.text = "johann"
            self.velocityLabel.text = "\(student.velocity)"
            self.completionLabel.text = "\(student.completedLabsCount)/\(student.totalLabsCount)"
//            if let profileUrl = student.githubGravatar, let url = URL(string: profileUrl) {
//                self.profileImageView.kf.setImage(with: url)
//            }
            let profileUrl = "https://avatars.githubusercontent.com/u/20468684"
            if let url = URL(string: profileUrl) {
                self.profileImageView.kf.setImage(with: url)
            }
        }
    }
    
}

