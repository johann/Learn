//
//  LearnApiTest.swift
//  LearnTests
//
//  Created by Luke Ghenco on 5/13/19.
//  Copyright © 2019 Johann Kerr. All rights reserved.
//

import XCTest

@testable import Learn

enum FileName: String {
    case profileFetchData
    case curriculumFetchData
    case emptyResponse
}

class TestJSON {
    let data: Data?
    let decoder: JSONDecoder
    
    init(_ fileName: FileName) {
        let bundle = Bundle(for: type(of: self))
        let url = bundle.url(forResource: fileName.rawValue, withExtension: "json")
        self.data = try? Data(contentsOf: url!)
        self.decoder = JSONDecoder()
        self.decoder.keyDecodingStrategy = .convertFromSnakeCase
    }
}

class LearnApiTest: XCTestCase {
    
    override func setUp() {}
    
    override func tearDown() {}
    
    // MARK: LearnApi.getProfile
    // MARK: - On Success
    func test_LearnAPI_GetProfile_ReturnsStudent() {
        class WebServiceMock: WebService {
            override func request(_ endPoint: Endpoint, headers: [String: String], method: String = "GET", result: @escaping (Result<Data, Error>) -> Void) {
                guard let data = TestJSON(.profileFetchData).data else {
                    XCTFail()
                    return
                }
                result(.success(data))
            }
        }
        
        LearnApi(WebServiceMock()).getProfile("abc") { (result) in
            switch result {
            case .success(let student):
                let testJSON = TestJSON(.profileFetchData)
                guard let studentStub = try? testJSON.decoder.decode(Student.self, from: testJSON.data!) else {
                    XCTFail("Unable to parse test JSON")
                    return
                }
                let trackStub = studentStub.activeTrack
                let batchStub = studentStub.activeBatch
                let courseStub = studentStub.activeCourse
                let activeTrack = student.activeTrack
                let activeBatch = student.activeBatch
                let activeCourse = student.activeCourse
                
                XCTAssert(student.gravatarUrl == studentStub.gravatarUrl, "student.gravatarURL should be: \(String(describing: studentStub.gravatarUrl))")
                XCTAssert(student.learnUuid == studentStub.learnUuid, "student.learnUuid should be: \(studentStub.learnUuid)")
                XCTAssert(student.displayName == studentStub.displayName, "student.displayName should be: \(studentStub.displayName)")
                XCTAssert(student.totalLessonsCount == studentStub.totalLessonsCount, "student.totalLessonsCount should be: \(studentStub.totalLessonsCount)")
                XCTAssert(student.email == studentStub.email, "student.email should be: \(studentStub.email)")
                XCTAssert(student.id == studentStub.id, "student.id should be: \(studentStub.id)")
                XCTAssert(student.velocity == studentStub.velocity, "student.velocity should be: \(studentStub.velocity)")
                XCTAssert(student.lastSeenAt == studentStub.lastSeenAt, "student.lastSeenAt should be: \(String(describing: studentStub.lastSeenAt))")
                XCTAssert(student.learnUsername == studentStub.learnUsername, "student.learnUsername should be: \(studentStub.learnUsername)")
                XCTAssert(activeTrack.id == trackStub.id, "activeTrack.id should be: \(trackStub.id)")
                XCTAssert(activeTrack.slug == trackStub.slug, "activeTrack.slag should be: \(trackStub.slug)")
                XCTAssert(activeTrack.title == trackStub.title, "activeTrack.title should be: \(trackStub.title)")
                XCTAssert(activeTrack.uuid == trackStub.uuid, "activeTrack.uuid should be: \(trackStub.uuid)")
                XCTAssert(activeBatch.id == batchStub.id, "activeBatch.id should be: \(batchStub.id)")
                XCTAssert(activeBatch.iteration == batchStub.iteration, "activeBatch.iteration should be: \(batchStub.iteration)")
                XCTAssert(activeBatch.displayName == batchStub.displayName, "activeBatch.displayName should be: \(batchStub.displayName)")
                XCTAssert(activeBatch.uuid == batchStub.uuid, "activeBatch.uuid should be: \(batchStub.uuid)")
                XCTAssert(activeCourse.id == courseStub.id, "activeCourse.id should be: \(String(describing: courseStub.id))")
                XCTAssert(activeCourse.slug == courseStub.slug, "activeCourse.iteration should be: \(String(describing: courseStub.slug))")
                XCTAssert(activeCourse.displayName == courseStub.displayName, "activeCourse.displayName should be: \(String(describing: courseStub.displayName))")
                XCTAssert(activeCourse.uuid == "aaa-111-bbb", "activeCourse.uuid should be: aaa-111-bbb")
            default:
                XCTFail()
            }
        }
    }
    
    // MARK: - On Failure
    func test_LearnAPI_GetProfileWithMalformedJSON_ReturnsNetworkError() {
        class WebServiceMock: WebService {
            override func request(_ endPoint: Endpoint, headers: [String: String], method: String = "GET", result: @escaping (Result<Data, Error>) -> Void) {
                guard let data = TestJSON(.emptyResponse).data else {
                    XCTFail()
                    return
                }
                result(.success(data))
            }
        }
        
        LearnApi(WebServiceMock()).getProfile("abc") { (result) in
            switch result {
            case .success(_):
                XCTFail()
            case .failure(let error):
                let networkError = error as! NetworkError
                XCTAssert(networkError == NetworkError.malformedJSON, "Should return NetworkError.malformedJSON")
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
                XCTAssert(networkError == NetworkError.urlFailure, "Should return NetworkError.urlFailure")
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
                XCTAssert(networkError == NetworkError.missingData, "Should return NetworkError.missingData")
            }
        }
    }
    
    // MARK: LearnApi.getCurriculum
    // MARK: - On Success
    func test_LearnAPI_GetCurriculum_ReturnsTrack() {
        class WebServiceMock: WebService {
            override func request(_ endPoint: Endpoint, headers: [String: String], method: String = "GET", result: @escaping (Result<Data, Error>) -> Void) {
                guard let data = TestJSON(.curriculumFetchData).data else {
                    XCTFail()
                    return
                }
                result(.success(data))
            }
        }
        
        LearnApi(WebServiceMock()).getCurriculum("abc", userId: 26, batchId: 11, trackId: 1) { (result) in
            switch result {
            case .success(let track):
                let testJSON = TestJSON(.curriculumFetchData)
                guard let trackStub = try? testJSON.decoder.decode(Track.self, from: testJSON.data!),
                    let topicStub = trackStub.topics?[0],
                    let unitStub = topicStub.units?[0],
                    let lessonStub = unitStub.lessons?[0],
                    let topic = track.topics?[0],
                    let unit = topic.units?[0],
                    let lesson = unit.lessons?[0]
                else {
                    XCTFail()
                    return
                }
                
                XCTAssert(track.id == trackStub.id, "The Track's id should be: \(trackStub.id)")
                XCTAssert(track.slug == trackStub.slug, "The Track's slug should be: \(trackStub.slug)")
                XCTAssert(track.title == trackStub.title, "The Tracks's title should be: \(trackStub.title)")
                XCTAssert(track.uuid == trackStub.uuid, "The Tracks's uuid should be: \(trackStub.uuid)")
                XCTAssert(topic.id == topicStub.id, "The topic.id should be: \(topicStub.id)")
                XCTAssert(topic.slug == topicStub.slug, "The topic.slug should be \(topicStub.slug)")
                XCTAssert(topic.title == topicStub.title, "The topic.title should be: \(topicStub.title)")
                XCTAssert(unit.id == unitStub.id, "The unit.id should be: \(unitStub.id)")
                XCTAssert(unit.title == unitStub.title, "The unit.title should be: \(unitStub.title)")
                XCTAssert(unit.slug == unitStub.slug, "The unit.slug should be: \(unitStub.slug)")
                XCTAssert(lesson.id == lessonStub.id, "The lesson.id should be: \(lessonStub.id)")
                XCTAssert(lesson.readme == lessonStub.readme, "The lesson.readme should be: \(lessonStub.readme)")
                XCTAssert(lesson.slug == lessonStub.slug, "The lesson.slug should be: \(lessonStub.slug)")
                XCTAssert(lesson.title == lessonStub.title, "The lesson.title should be: \(lessonStub.title)")
            default:
                XCTFail()
            }
        }
    }
    
    // MARK: - On Failure
    func test_LearnAPI_GetCurriculumWithMalformedJSON_ReturnsNetworkError() {
        class WebServiceMock: WebService {
            override func request(_ endPoint: Endpoint, headers: [String: String], method: String = "GET", result: @escaping (Result<Data, Error>) -> Void) {
                guard let data = TestJSON(.emptyResponse).data else {
                    XCTFail()
                    return
                }
                result(.success(data))
            }
        }
        
        LearnApi(WebServiceMock()).getCurriculum("abc", userId: 26, batchId: 11, trackId: 1) { (result) in
            switch result {
            case .success(_):
                XCTFail()
            case .failure(let error):
                let networkError = error as! NetworkError
                XCTAssert(networkError == NetworkError.malformedJSON, "Should return NetworkError.malformedJSON")
            }
        }
    }
    
    func test_LearnAPI_GetCurriculumWithBadURL_ReturnsNetWorkError() {
        class WebServiceMock: WebService {
            
            override func request(_ endPoint: Endpoint, headers: [String: String], method: String = "GET", result: @escaping (Result<Data, Error>) -> Void) {
                result(.failure(NetworkError.urlFailure))
            }
        }
        
        LearnApi(WebServiceMock()).getCurriculum("abc", userId: 26, batchId: 11, trackId: 1)  { (result) in
            switch result {
            case .success(_):
                XCTFail()
            case .failure(let error):
                let networkError = error as! NetworkError
                XCTAssert(networkError == NetworkError.urlFailure, "Should return NetworkError.urlFailure")
            }
        }
    }
    
    func test_LearnAPI_GetCurriculumWithMissingData_ReturnsNetworkError() {
        class WebServiceMock: WebService {
            
            override func request(_ endPoint: Endpoint, headers: [String: String], method: String = "GET", result: @escaping (Result<Data, Error>) -> Void) {
                result(.failure(NetworkError.missingData))
            }
        }
        
        LearnApi(WebServiceMock()).getCurriculum("abc", userId: 26, batchId: 11, trackId: 1)  { (result) in
            switch result {
            case .success(_):
                XCTFail()
            case .failure(let error):
                let networkError = error as! NetworkError
                XCTAssert(networkError == NetworkError.missingData, "Should return NetworkError.missingData")
            }
        }
    }
}
