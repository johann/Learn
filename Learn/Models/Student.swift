//
//  Student.swift
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
    var learnUuid: String
    var displayName: String
    var lastSeenAt: String?
    var learnUsername: String
    var gravatarUrl: String?
    var velocity: Int
    var completedLessonsCount: Int
    var totalLessonsCount: Int
    var email: String
    var activeBatch: Batch
    var activeTrack: Track
    var activeCourse: Course
}

