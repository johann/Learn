//
//  LessonViewController.swift
//  Learn
//
//  Created by Johann Kerr on 7/20/18.
//  Copyright © 2018 Johann Kerr. All rights reserved.
//
import Foundation
import UIKit
import Down

class LessonViewController: UIViewController {
  let store = UserDataStore.shared
  var lesson = Lesson()
  
  override func viewDidLoad() {
    super.viewDidLoad()
  }
  
  override func viewWillAppear(_ animated: Bool) {
    super.viewWillAppear(animated)
//    store.fetchLesson(lessonId: <#T##Int#>, completion: <#T##(String) -> ()#>)
//    store.fetchCurrentLesson { (lesson) in
//      if let readme = lesson?.readme {
//        DispatchQueue.main.async {
//          self.createView(readme: readme)
//        }
//      }
//    }
  }
  
  func createView(readme: String) {
    if let view = try? DownView(frame: CGRect(x: 0, y: 0, width: self.view.frame.width, height: self.view.frame.height), markdownString: readme) {
      self.view.addSubview(view)
    }
  }
  
}
