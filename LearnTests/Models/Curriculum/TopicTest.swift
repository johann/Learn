//
//  TopicTest.swift
//  LearnTests
//
//  Created by Luke Ghenco on 5/15/19.
//  Copyright © 2019 Johann Kerr. All rights reserved.
//
import XCTest
@testable import Learn

final class TopicTest: XCTestCase {
    
    override func setUp() {}
    
    override func tearDown() {}
    
    
    // Mark .init()
    func test_TopicInit_WithMissingId_ThrowsError() {
        XCTAssertThrowsError(try JSONDecoder().decode(Topic.self, from: topicDataMissingId)) { error in
            if case .keyNotFound(let key, _)? = error as? DecodingError {
                XCTAssertEqual("id", key.stringValue)
            } else {
                XCTFail("Expected '.keyNotFound' for 'id' but error was: \(error)")
            }
        }
    }
    
    func test_TopicInit_WithMissingSlug_ThrowsError() {
        XCTAssertThrowsError(try JSONDecoder().decode(Topic.self, from: topicDataMissingSlug)) { error in
            if case .keyNotFound(let key, _)? = error as? DecodingError {
                XCTAssertEqual("slug", key.stringValue)
            } else {
                XCTFail("Expected '.keyNotFound' for 'slug' but error was: \(error)")
            }
        }
    }
    
    func test_TopicInit_WithMissingTitle_ThrowsError() {
        XCTAssertThrowsError(try JSONDecoder().decode(Topic.self, from: topicDataMissingTitle)) { error in
            if case .keyNotFound(let key, _)? = error as? DecodingError {
                XCTAssertEqual("title", key.stringValue)
            } else {
                XCTFail("Expected '.keyNotFound' for 'title' but error was: \(error)")
            }
        }
    }
    
    // Mark .isComplete
    func test_TopicIsComplete_WhenItHasNoUnits_ReturnsTrue() throws {
        let sut = try JSONDecoder().decode(Topic.self, from: topicDataWithoutUnits)

        XCTAssertTrue(sut.isComplete, ".isComplete should be true if there are no associated units")
    }
    
    func test_TopicIsComplete_WhenItHasUnitsWithNoLessons_ReturnsTrue() throws {
        let sut = try JSONDecoder().decode(Topic.self, from: topicDataWithNoLessonUnits)
        
        XCTAssertTrue(sut.isComplete, ".isComplete should be true if there are no associated lessons for a unit")
    }
    
    func test_TopicIsComplete_WhenAllUnitLessonsAreCompleted_ReturnsTrue() throws {
        let sut = try JSONDecoder().decode(Topic.self, from: topicDataAllUnitLessonsCompleted)
        
        XCTAssertTrue(sut.isComplete, ".isComplete should be true if all lessons for all units")
    }
    
    func test_TopicIsComplete_WhenAnyUnitLessonsAreNotCompleted_ReturnsFalse() throws {
        let sut = try JSONDecoder().decode(Topic.self, from: topicDataSomeUnitLessonsCompleted)
        
        XCTAssertFalse(sut.isComplete, ".isComplete should be false if any unit lessons are not competed")
    }
    
    // Mark .lessonCount
    func test_TopicLessonCount_WhenItHasNoUnits_ReturnsZero() throws {
        let sut = try JSONDecoder().decode(Topic.self, from: topicDataWithoutUnits)
        
        XCTAssert(sut.lessonCount == 0, ".lessonCount should be 0 if there are no associated units")
    }
    
    func test_TopicLessonCount_WhenItHasUnitsWithNoLessons_ReturnsZero() throws {
        let sut = try JSONDecoder().decode(Topic.self, from: topicDataWithoutUnits)
        
        XCTAssert(sut.lessonCount == 0, ".lessonCount should be 0 if there are no associated lessons for a unit")
    }
    
    func test_TopicLessonCount_WhenUnitsHaveLessons_ReturnsCountOfUnitLessons() throws {
        let sut = try JSONDecoder().decode(Topic.self, from: topicDataAllUnitLessonsCompleted)
        
        XCTAssert(sut.lessonCount == 4, ".lessonCount should be 4")
    }
    
    // Mark .lessonCompletionCount
    func test_TopicLessonCompletionCount_WhenItHasNoUnits_ReturnsZero() throws {
        let sut = try JSONDecoder().decode(Topic.self, from: topicDataWithoutUnits)
        
        XCTAssert(sut.lessonCompletionCount == 0, ".lessonCompletionCount should be 0 if there are no associated units")
    }
    
    func test_TopicLessonCompletionCount_WhenItHasUnitsWithNoLessons_ReturnsZero() throws {
        let sut = try JSONDecoder().decode(Topic.self, from: topicDataWithNoLessonUnits)
        
        XCTAssert(sut.lessonCompletionCount == 0, ".lessonCompletionCount should be 0 if there are no associated lessons for a unit")
    }
    
    func test_TopicLessonCompletionCount_WhenAllUnitLessonsAreComplete_ReturnsCountOfAllUnitLessons() throws {
        let sut = try JSONDecoder().decode(Topic.self, from: topicDataAllUnitLessonsCompleted)
        
        XCTAssert(sut.lessonCompletionCount == 4, ".lessonCompletionCount should equal count of all unit lessons")
    }
    
    func test_TopicLessonCompletionCount_WhenSomeUnitLessonsAreNotCompleted_ReturnsCountOfOnlyCompletedUnitLessons() throws {
        let sut = try JSONDecoder().decode(Topic.self, from: topicDataSomeUnitLessonsCompleted)
        
        XCTAssert(sut.lessonCompletionCount == 3, ".lessonCompletionCount should equal count of only completed unit lessons")
    }
}

private let topicDataMissingId = Data("""
{
    "slug": "python",
    "title": "Python"
}
""".utf8)

private let topicDataMissingSlug = Data("""
{
    "id": 1,
    "title": "Python"
}
""".utf8)

private let topicDataMissingTitle = Data("""
{
    "id": 1,
    "slug": "python"
}
""".utf8)

private let topicDataWithoutUnits = Data("""
{
    "id": 1,
    "slug": "python",
    "title": "Python"
}
""".utf8)

private let topicDataWithNoLessonUnits = Data("""
{
    "id": 1,
    "slug": "python",
    "title": "Python",
    "units": [
        {
            "id": 1,
            "slug": "intro-to-ds",
            "title": "Intro to DS"
        },
        {
            "id": 2,
            "slug": "regression",
            "title": "Regression"
        }
    ]
}
""".utf8)

private let topicDataAllUnitLessonsCompleted = Data("""
{
    "id": 1,
    "slug": "python",
    "title": "Python",
    "units": [
        {
            "id": 1,
            "slug": "intro-to-ds",
            "title": "Intro to DS",
            "lessons": [
                {
                    "id": 1,
                    "slug": "functions",
                    "title": "Functions",
                    "readme": "test readme file",
                    "isComplete": true
                },
                {
                    "id": 2,
                    "slug": "arrays",
                    "title": "Arrays",
                    "readme": "test readme file",
                    "isComplete": true
                }
            ]
        },
        {
            "id": 2,
            "slug": "regression",
            "title": "Regression",
            "lessons": [
                {
                    "id": 3,
                    "slug": "strings",
                    "title": "Strings",
                    "readme": "test readme file",
                    "isComplete": true
                },
                {
                    "id": 4,
                    "slug": "data",
                    "title": "Data",
                    "readme": "test readme file",
                    "isComplete": true
                }
            ]
        }
    ]
}
""".utf8)

private let topicDataSomeUnitLessonsCompleted = Data("""
{
    "id": 1,
    "slug": "python",
    "title": "Python",
    "units": [
        {
            "id": 1,
            "slug": "intro-to-ds",
            "title": "Intro to DS",
            "lessons": [
                {
                    "id": 1,
                    "slug": "functions",
                    "title": "Functions",
                    "readme": "test readme file",
                    "isComplete": true
                },
                {
                    "id": 2,
                    "slug": "arrays",
                    "title": "Arrays",
                    "readme": "test readme file",
                    "isComplete": true
                }
            ]
        },
        {
            "id": 2,
            "slug": "regression",
            "title": "Regression",
            "lessons": [
                {
                    "id": 3,
                    "slug": "strings",
                    "title": "Strings",
                    "readme": "test readme file",
                    "isComplete": true
                },
                {
                    "id": 4,
                    "slug": "data",
                    "title": "Data",
                    "readme": "test readme file",
                    "isComplete": false
                }
            ]
        }
    ]
}
""".utf8)
