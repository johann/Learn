//
//  UnitTest.swift
//  LearnTests
//
//  Created by Luke Ghenco on 5/15/19.
//  Copyright © 2019 Johann Kerr. All rights reserved.
//

import XCTest
@testable import Learn

final class UnitTest: XCTestCase {
    
    override func setUp() {}
    
    override func tearDown() {}
    
    
    // Mark .init()
    func test_UnitInit_WithMissingId_ThrowsError() {
        XCTAssertThrowsError(try JSONDecoder().decode(Unit.self, from: unitDataMissingId)) { error in
            if case .keyNotFound(let key, _)? = error as? DecodingError {
                XCTAssertEqual("id", key.stringValue)
            } else {
                XCTFail("Expected '.keyNotFound' for 'id' but error was: \(error)")
            }
        }
    }
    
    func test_UnitInit_WithMissingSlug_ThrowsError() {
        XCTAssertThrowsError(try JSONDecoder().decode(Unit.self, from: unitDataMissingSlug)) { error in
            if case .keyNotFound(let key, _)? = error as? DecodingError {
                XCTAssertEqual("slug", key.stringValue)
            } else {
                XCTFail("Expected '.keyNotFound' for 'slug' but error was: \(error)")
            }
        }
    }
    
    func test_UnitInit_WithMissingTitle_ThrowsError() {
        XCTAssertThrowsError(try JSONDecoder().decode(Unit.self, from: unitDataMissingTitle)) { error in
            if case .keyNotFound(let key, _)? = error as? DecodingError {
                XCTAssertEqual("title", key.stringValue)
            } else {
                XCTFail("Expected '.keyNotFound' for 'title' but error was: \(error)")
            }
        }
    }
    
    // Mark .isComplete()
    func test_UnitIsComplete_WhenItHasNoLessons_ReturnsTrue() throws {
        let sut = try JSONDecoder().decode(Unit.self, from: unitDataWithoutLessons)
        
        XCTAssert(sut.isComplete() == true, ".isComplete should be true there are no associated lessons")
    }
    
    func test_UnitIsComplete_WhenAllLessonsAreCompleted_ReturnsTrue() throws {
        let sut = try JSONDecoder().decode(Unit.self, from: unitDataWithCompletedLessons)
        
        XCTAssert(sut.isComplete() == true, ".isComplete should be true when all lessons are completed")
    }
    
    func test_UnitIsComplete_WhenNoLessonsAreCompleted_ReturnsFalse() throws {
        let sut = try JSONDecoder().decode(Unit.self, from: unitDataWithNoCompletedLessons)
        
        XCTAssert(sut.isComplete() == false, ".isComplete should be false if no lessons are completed")
    }
    
    func test_UnitIsComplete_WhenSomeLessonsAreCompleted_ReturnsFalse() throws {
        let sut = try JSONDecoder().decode(Unit.self, from: unitDataWithSomeCompletedLessons)
        
        XCTAssert(sut.isComplete() == false, ".isComplete should be false if not all (but some) lessons are completed")
    }
    
    // MARK .completedLessonsCount()
    func test_UnitCompletedLessonCount_WhenItHasNoLessons_Returns0() throws {
        let sut = try JSONDecoder().decode(Unit.self, from: unitDataWithoutLessons)
        
        XCTAssert(sut.completedLessonCount() == 0, ".completedLessonCount() should be `0` if there are no associated lessons")
    }
    
    func test_UnitCompletedLessonCount_WhenAllLessonsAreCompleted_ReturnsSameCountAsLessons() throws {
        let sut = try JSONDecoder().decode(Unit.self, from: unitDataWithCompletedLessons)
        let lessonCount = sut.lessons?.count
        
        XCTAssert(sut.completedLessonCount() == lessonCount, ".completedLessonCount() should be \(String(describing: lessonCount)) when all lessons are completed")
    }
    
    func test_UnitCompletedLessonCount_WhenNoLessonsAreCompleted_Returns0() throws {
        let sut = try JSONDecoder().decode(Unit.self, from: unitDataWithNoCompletedLessons)
        
        XCTAssert(sut.completedLessonCount() == 0, ".completedLessonCount() should be `0` false if no lessons are completed")
    }
    
    func test_UnitCompletedLessonCount_WhenSomeLessonsAreCompleted_ReturnsCountOfLessonsMarkedComplete() throws {
        let sut = try JSONDecoder().decode(Unit.self, from: unitDataWithSomeCompletedLessons)
        let completedLessonCount = sut.lessons?.filter{ $0.isComplete }.count
        
        XCTAssert(sut.completedLessonCount() == completedLessonCount, ".isComplete should equal \(String(describing: completedLessonCount)) if not all (but some) lessons are completed")
    }
}

private let unitDataWithoutLessons = Data("""
{
    "id": 1,
    "slug": "intro-to-ds",
    "title": "Intro to DS"
}
""".utf8)

private let unitDataMissingId = Data("""
{
    "slug": "intro-to-ds",
    "title": "Intro to DS"
}
""".utf8)

private let unitDataMissingSlug = Data("""
{
    "id": 1,
    "title": "Intro to DS"
}
""".utf8)

private let unitDataMissingTitle = Data("""
{
    "id": 1,
    "slug": "intro-to-ds"
}
""".utf8)

private let unitDataWithCompletedLessons = Data("""
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
}
""".utf8)

private let unitDataWithNoCompletedLessons = Data("""
{
    "id": 1,
    "slug": "intro-to-ds",
    "title": "Intro to DS",
    "lessons": [
        {
            "id": 1,
            "slug": "functions",
            "title": "Functions",
            "readme": "test readme file"
        },
        {
            "id": 2,
            "slug": "arrays",
            "title": "Arrays",
            "readme": "test readme file"
        }
    ]
}
""".utf8)

private let unitDataWithSomeCompletedLessons = Data("""
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
            "readme": "test readme file"
        }
    ]
}
""".utf8)
