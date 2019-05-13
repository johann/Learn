//
//  LearnApiTest.swift
//  LearnTests
//
//  Created by Luke Ghenco on 5/13/19.
//  Copyright © 2019 Johann Kerr. All rights reserved.
//

import XCTest

@testable import Learn

class LearnApiTest: XCTestCase {
    
    override func setUp() {}
    
    override func tearDown() {}
    
    // MARK: LearnApi.getProfile
    // MARK: - On Success
    func test_LearnAPI_GetProfile_ReturnsStudent() {
        class WebServiceMock: WebService {
            
            override func request(_ endPoint: Endpoint, headers: [String: String], method: String = "GET", result: @escaping (Result<Data, Error>) -> Void) {
                let data = Data(AdaptersTestData.successfulLearnAPIProfileJSON.utf8)
                result(.success(data))
            }
        }
        
        LearnApi(WebServiceMock()).getProfile("abc") { (result) in
            switch result {
            case .success(let student):
                let activeTrack = student.activeTrack
                let activeBatch = student.activeBatch
                let activeCourse = student.activeCourse
                
                XCTAssertTrue(student.gravatarUrl == "https://avatars.githubusercontent.com/u/123456", "The Student's gravatarURL should be: https://avatars.githubusercontent.com/u/123456")
                XCTAssertTrue(student.learnUuid == "111-222-333", "The Student's active learnUuid should be: 111-222-333")
                XCTAssertTrue(student.displayName == "Flint Lockwood", "The Student's displayName should be: Flint Lockwood")
                XCTAssertTrue(student.totalLessonsCount == 4, "The Student's totalLessonsCount should be: 4")
                XCTAssertTrue(student.email == "test@gmail.com", "The Student's email should be: test@gmail.com")
                XCTAssertTrue(student.id == 26, "The Student's email should be 26")
                XCTAssertTrue(student.velocity == 0, "The Students's velocity should be 0")
                XCTAssertTrue(student.lastSeenAt == "2019-03-12 01:18:01", "The Student's result should be 2019-03-12 01:18:01")
                XCTAssertTrue(student.learnUsername == "steadfast-delimiter-7257", "The Student's learnUsername should be: steadfast-delimiter-7257")
                
                XCTAssertTrue(activeTrack.id == 1, "The Student's active track id should be: 1")
                XCTAssertTrue(activeTrack.slug == "intro-to-data-science", "The Student's active track slag should be: intro-to-data-science")
                XCTAssertTrue(activeTrack.title == "Intro to Data Science", "The Student's active track title should be: Intro to Data Science")
                XCTAssertTrue(activeTrack.uuid == "aaa-bbb-ccc", "The Student's active track uuid should be: aaa-bbb-ccc")
                
                XCTAssertTrue(activeBatch.id == 11, "The Student's active batch id should be: 11")
                XCTAssertTrue(activeBatch.iteration == "online-ds-sp-000", "The Student's active batch iteration should be: online-ds-sp-000")
                XCTAssertTrue(activeBatch.displayName == "Online DS SP-000", "The Student's active batch displayName should be: Online DS SP-000")
                XCTAssertTrue(activeBatch.uuid == "111-aaa-222", "The Student's active batch uuid should be: 111-aaa-222")
                
                XCTAssertTrue(activeCourse.id == 15, "The Student's activeCourse.id should be: 11")
                XCTAssertTrue(activeCourse.slug == "online-data-science-bootcamp", "The Student's activeCourse.iteration should be: online-data-science-bootcamp")
                XCTAssertTrue(activeCourse.displayName == "Online Data Science Bootcamp", "The Student's activeCourse.displayName should be: Online Data Science Bootcamp")
                XCTAssertTrue(activeCourse.uuid == "aaa-111-bbb", "The Student's activeCourse.uuid should be: aaa-111-bbb")
            default:
                XCTFail()
            }
        }
    }
    
    // MARK: - On Failure
    func test_LearnAPI_GetProfileWithMalformedJSON_ReturnsNetworkError() {
        class WebServiceMock: WebService {
            override func request(_ endPoint: Endpoint, headers: [String: String], method: String = "GET", result: @escaping (Result<Data, Error>) -> Void) {
                let data = Data(AdaptersTestData.unsuccessfulLearnAPIProfileJSON.utf8)
                print(data)
                result(.success(data))
            }
        }
        
        LearnApi(WebServiceMock()).getProfile("abc") { (result) in
            switch result {
            case .success(_):
                XCTFail()
            case .failure(let error):
                let networkError = error as! NetworkError
                XCTAssertTrue(networkError == NetworkError.malformedJSON, "Should return NetworkError.malformedJSON")
            }
        }
    }
    
    
    
    func test_LearnAPI_GetProfileWithBadURL_ReturnsNetWorkError() {
        class WebServiceMock: WebService {
            
            override func request(_ endPoint: Endpoint, headers: [String: String], method: String = "GET", result: @escaping (Result<Data, Error>) -> Void) {
                result(.failure(NetworkError.urlFailure))
            }
        }
        
        LearnApi(WebServiceMock()).getProfile("abc") { (result) in
            switch result {
            case .success(_):
                XCTFail()
            case .failure(let error):
                let networkError = error as! NetworkError
                XCTAssertTrue(networkError == NetworkError.urlFailure, "Should return NetworkError.urlFailure")
            }
        }
    }
    
    func test_LearnAPI_GetProfileWithMissingData_ReturnsNetworkError() {
        class WebServiceMock: WebService {
            
            override func request(_ endPoint: Endpoint, headers: [String: String], method: String = "GET", result: @escaping (Result<Data, Error>) -> Void) {
                result(.failure(NetworkError.missingData))
            }
        }
        
        LearnApi(WebServiceMock()).getProfile("abc") { (result) in
            switch result {
            case .success(_):
                XCTFail()
            case .failure(let error):
                let networkError = error as! NetworkError
                XCTAssertTrue(networkError == NetworkError.missingData, "Should return NetworkError.missingData")
            }
        }
    }
    
    // MARK: LearnApi.getCurriculum
    // MARK: - On Success
    func test_LearnAPI_GetCurriculum_ReturnsTrack() {
        class WebServiceMock: WebService {
            
            override func request(_ endPoint: Endpoint, headers: [String: String], method: String = "GET", result: @escaping (Result<Data, Error>) -> Void) {
                let data = Data(AdaptersTestData.successfulLearnAPITrackJSON.utf8)
                result(.success(data))
            }
        }
        
        LearnApi(WebServiceMock()).getCurriculum("abc", userId: 26, batchId: 11, trackId: 1) { (result) in
            switch result {
            case .success(let track):
//                let topic = track.topics?[0]
//                let unit = topic.units?[0]
//                let lesson = unit.lessons?[0]
                
                XCTAssertTrue(track.id == 1, "The Track's id should be: 1")
                XCTAssertTrue(track.slug == "intro-to-data-science", "The Track's slug should be: intro-to-data-science")
                XCTAssertTrue(track.title == "Intro to Data Science", "The Tracks's title should be: Intro to Data Science")
                XCTAssertTrue(track.uuid == "111-222-333", "The Tracks's uuid should be: 111-222-333")
                // TODO: Add additional tests
                
            default:
                XCTFail()
            }
        }
    }
}
