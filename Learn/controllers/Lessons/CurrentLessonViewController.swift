//
//  CurrentLessonViewController.swift
//  Learn
//
//  Created by Johann Kerr on 3/1/19.
//  Copyright © 2019 Johann Kerr. All rights reserved.
//

import Foundation
import UIKit
import Down

class CurrentLessonViewController: UIViewController {
  let store = UserDataStore.shared
  
  override func viewDidLoad() {
    super.viewDidLoad()
  }
  
  override func viewWillAppear(_ animated: Bool) {
    super.viewWillAppear(animated)
    store.fetchCurrentLesson { (lesson) in
      if let readme = lesson?.readme {
        DispatchQueue.main.async {
          self.createView(readme: readme)
        }
      }
    }
  }
  
  func createView(readme: String) {
    if let view = try? DownView(frame: CGRect(x: 0, y: 0, width: self.view.frame.width, height: self.view.frame.height), markdownString: readme) {
      self.view.addSubview(view)
    }
  }
  
}
