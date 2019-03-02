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
import IKEventSource
import SCLAlertView

//learn-auth://learn/callback


class HomeViewController: UIViewController {
    @IBOutlet weak var profileImageView: UIImageView!
    @IBOutlet weak var nameLabel: UILabel!
    var currentMessage: [String: String] = [:]
    
    let store = UserDataStore.shared


    override func viewDidLoad() {
        super.viewDidLoad()
        
        store.fetchStudent { (student) in
            self.connectToEventSource(userId: student.id)
            self.updateViewWith(student)
        }
      
        
    }
    
    func connectToEventSource(userId: Int) {

        var eventSource: EventSource = EventSource(url: "https://push.flatironschool.com:9443/ev/fis-user-\(userId)?_=1538669844196&tag=&time=&eventid=")
        
        eventSource.onOpen {
            // When opened
            print("Open")
        }
        

        eventSource.onError { (error) in
            // When errors
            print("on error", error)
        }
        
        eventSource.onMessage { (id, event, data) in
//            print(event, data)
            if let stringData = data, let stringEncodedData = stringData.data(using: .utf8) {
                if let json = try! JSONSerialization.jsonObject(with: stringEncodedData, options: []) as? [String: Any] {
                    if let messageText = json["text"] as? String {

                        let message = self.parseMessage(message: messageText)
                        if !self.checkIfMessageAlreadyExists(message: message) {
                            self.currentMessage = message
                            print(message)
                            self.fetchLessonAndUpdateView(message: message)
                        }
                    
                    }
                }
                
            }
        }
    }
    func checkIfMessageAlreadyExists(message: [String: String]) -> Bool {
        if let currentMessageValue = self.currentMessage["message"], let checkMessage = message["message"], let currentLesson = self.currentMessage["assigned_repo_id"], let checkLesson = message["assigned_repo_id"]  {
            if currentMessageValue == checkMessage && currentLesson == checkLesson {
                return true
            }
        }
       
        return false
       
    }
    
    func fetchLessonAndUpdateView(message: [String: String]) {
        let lessonId = Int(message["lesson_id"]!)
        store.fetchLesson(lessonId: lessonId!) { (lessonTitle) in
            let learnMessage = message["message"]
            let alertView = SCLAlertView()
            alertView.showSuccess(lessonTitle, subTitle: learnMessage!)
            
           
        }
        
    }
    
    
    func parseMessage(message: String) -> [String: String]{
        var messageObj : [String:String] = [:]
        message.components(separatedBy: "&").forEach { (pair) in
            let values = pair.components(separatedBy: "=")
            messageObj[values[0]] = values[1].replacingOccurrences(of: "+", with: " ")
        }
        return messageObj
    }
    
    func updateViewWith(_ student: Student) {
        DispatchQueue.main.async {
            self.nameLabel.text = student.fullName
    
            if let profileUrl = student.avatarUrl, let url = URL(string: profileUrl) {
                print(url)
                self.profileImageView.kf.setImage(with: url)
            }
        }
    }
    

}

