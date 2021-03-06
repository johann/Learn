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
    
    // MARK .currentLesson
    func test_UnitCurrentLesson_WhenItHasNoLessons_ReturnsNil() throws {
        let sut = try JSONDecoder().decode(Unit.self, from: unitDataWithoutLessons)
        
        XCTAssertNil(sut.currentLesson, "The `.currentLesson` should be nil if a unit has no lessons")
    }
    
    func test_UnitCurrentLesson_WhenAllLessonsAreComplete_ReturnsNil() throws {
        let sut = try JSONDecoder().decode(Unit.self, from: unitDataWithCompletedLessons)
        
        XCTAssertNil(sut.currentLesson, "The `.currentLesson` should be nil if all lessons are complete")
    }
    
    func test_UnitCurrentLesson_WhenFirstLessonIsCompleteButSecondLessonIsNot_ReturnsSecondLesson() throws {
        let sut = try JSONDecoder().decode(Unit.self, from: unitDataWithSomeCompletedLessons)
        let secondLesson = sut.lessons?[1]
        
        XCTAssertEqual(sut.currentLesson, secondLesson, "The `.currentLesson` should equal the second lesson")
    }
    
    func test_UnitCurrentLesson_WhenMoreThanOneLessonIsIncomplete_ReturnsFirstIncompleteLesson() throws {
        let sut = try JSONDecoder().decode(Unit.self, from: unitDataWithManyIncompleteLessons)
        let firstIncompleteLesson = sut.lessons?.first(where: { !$0.isComplete })
        
        XCTAssertEqual(sut.currentLesson, firstIncompleteLesson, "The `.currentLesson` should equal the first incomplete lesson")
    }
    
    // Mark .isComplete
    func test_UnitIsComplete_WhenItHasNoLessons_ReturnsTrue() throws {
        let sut = try JSONDecoder().decode(Unit.self, from: unitDataWithoutLessons)
        
        XCTAssertTrue(sut.isComplete, ".isComplete should be true there are no associated lessons")
    }
    
    func test_UnitIsComplete_WhenAllLessonsAreCompleted_ReturnsTrue() throws {
        let sut = try JSONDecoder().decode(Unit.self, from: unitDataWithCompletedLessons)
        
        XCTAssertTrue(sut.isComplete, ".isComplete should be true when all lessons are completed")
    }
    
    func test_UnitIsComplete_WhenNoLessonsAreCompleted_ReturnsFalse() throws {
        let sut = try JSONDecoder().decode(Unit.self, from: unitDataWithNoCompletedLessons)
        
        XCTAssertFalse(sut.isComplete, ".isComplete should be false if no lessons are completed")
    }
    
    func test_UnitIsComplete_WhenSomeLessonsAreCompleted_ReturnsFalse() throws {
        let sut = try JSONDecoder().decode(Unit.self, from: unitDataWithSomeCompletedLessons)
        
        XCTAssertFalse(sut.isComplete, ".isComplete should be false if not all (but some) lessons are completed")
    }
    
    // MARK .completedLessonsCount
    func test_UnitCompletedLessonCount_WhenItHasNoLessons_ReturnsZero() throws {
        let sut = try JSONDecoder().decode(Unit.self, from: unitDataWithoutLessons)
        
        XCTAssert(sut.completedLessonCount == 0, ".completedLessonCount() should be `0` if there are no associated lessons")
    }
    
    func test_UnitCompletedLessonCount_WhenAllLessonsAreCompleted_ReturnsSameCountAsLessons() throws {
        let sut = try JSONDecoder().decode(Unit.self, from: unitDataWithCompletedLessons)
        let lessonCount = sut.lessons?.count
        
        XCTAssert(sut.completedLessonCount == lessonCount, ".completedLessonCount() should be \(String(describing: lessonCount)) when all lessons are completed")
    }
    
    func test_UnitCompletedLessonCount_WhenNoLessonsAreCompleted_ReturnsZero() throws {
        let sut = try JSONDecoder().decode(Unit.self, from: unitDataWithNoCompletedLessons)
        
        XCTAssert(sut.completedLessonCount == 0, ".completedLessonCount() should be `0` false if no lessons are completed")
    }
    
    func test_UnitCompletedLessonCount_WhenSomeLessonsAreCompleted_ReturnsCountOfLessonsMarkedComplete() throws {
        let sut = try JSONDecoder().decode(Unit.self, from: unitDataWithSomeCompletedLessons)
        let completedLessonCount = sut.lessons?.filter{ $0.isComplete }.count
        
        XCTAssert(sut.completedLessonCount == completedLessonCount, ".isComplete should equal \(String(describing: completedLessonCount)) if not all (but some) lessons are completed")
    }
}

private let incompleteArraysLesson = """
{
    "id": 2,
    "slug": "arrays",
    "title": "Arrays",
    "readme": "test readme file"
}
"""

private let incompleteFunctionsLessons = """
{
    "id": 1,
    "slug": "functions",
    "title": "Functions",
    "readme": "test readme file"
}
"""

private let completedArraysLesson = """
{
    "id": 2,
    "slug": "arrays",
    "title": "Arrays",
    "readme": "test readme file",
    "isComplete": true
}
"""

private let completedFunctionsLesson = """
{
    "id": 1,
    "slug": "functions",
    "title": "Functions",
    "readme": "test readme file",
    "isComplete": true
}
"""

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
        \(completedFunctionsLesson),
        \(completedArraysLesson)
    ]
}
""".utf8)

private let unitDataWithNoCompletedLessons = Data("""
{
    "id": 1,
    "slug": "intro-to-ds",
    "title": "Intro to DS",
    "lessons": [
        \(incompleteFunctionsLessons),
        \(incompleteArraysLesson)
    ]
}
""".utf8)

private let unitDataWithSomeCompletedLessons = Data("""
{
    "id": 1,
    "slug": "intro-to-ds",
    "title": "Intro to DS",
    "lessons": [
        \(completedFunctionsLesson),
        \(incompleteArraysLesson)
    ]
}
""".utf8)

private let unitDataWithManyIncompleteLessons = Data("""
{
    "id": 1,
    "slug": "intro-to-ds",
    "title": "Intro to DS",
    "lessons": [
        \(completedFunctionsLesson),
        \(incompleteArraysLesson),
        {
            "id": 3,
            "slug": "reduce",
            "title": "Reduce",
            "readme": "test readme file",
            "isComplete": true
        },
        {
            "id": 4,
            "slug": "map",
            "title": "Map",
            "readme": "test readme file"
        }
    ]
}
""".utf8)
