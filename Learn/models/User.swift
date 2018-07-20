//
//  User.swift
//  Learn
//
//  Created by Johann Kerr on 7/20/18.
//  Copyright © 2018 Johann Kerr. All rights reserved.
//

import Foundation

struct StudentDataTransformer : Codable {
    var studentBatchProgresses: [Student]
    var students: [Student] {
        return studentBatchProgresses
    }
}

struct Student: Codable {
    var id: Int
    var fullName: String
    var email: String
    var githubGravatar: String?
    var githubUsername: String?
    var lastSeenAt: String?
    var velocity: Int
    var completedLessonsCount: Int
    var totalLessonsCount: Int
    var completedLabsCount: Int
    var totalLabsCount: Int
    var batchId: String
    var trackId: String
}
