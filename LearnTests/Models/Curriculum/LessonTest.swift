//
//  LessonTest.swift
//  LearnTests
//
//  Created by Luke Ghenco on 5/15/19.
//  Copyright © 2019 Johann Kerr. All rights reserved.
//

import XCTest
@testable import Learn

final class LessonTest: XCTestCase {

    override func setUp() {}

    override func tearDown() {}
    
    func test_LessonInit_WithMissingId_ThrowsError() {
        XCTAssertThrowsError(try JSONDecoder().decode(Lesson.self, from: lessonDataMissingId)) { error in
            if case .keyNotFound(let key, _)? = error as? DecodingError {
                XCTAssertEqual("id", key.stringValue)
            } else {
                XCTFail("Expected '.keyNotFound' for 'id' but error was: \(error)")
            }
        }
    }
    
    func test_LessonInit_WithMissingSlug_ThrowsError() {
        XCTAssertThrowsError(try JSONDecoder().decode(Lesson.self, from: lessonDataMissingSlug)) { error in
            if case .keyNotFound(let key, _)? = error as? DecodingError {
                XCTAssertEqual("slug", key.stringValue)
            } else {
                XCTFail("Expected '.keyNotFound' for 'slug' but error was: \(error)")
            }
        }
    }
    
    func test_LessonInit_WithMissingTitle_ThrowsError() {
        XCTAssertThrowsError(try JSONDecoder().decode(Lesson.self, from: lessonDataMissingTitle)) { error in
            if case .keyNotFound(let key, _)? = error as? DecodingError {
                XCTAssertEqual("title", key.stringValue)
            } else {
                XCTFail("Expected '.keyNotFound' for 'title' but error was: \(error)")
            }
        }
    }
    
    func test_LessonInit_WithMissingReadmeAttr_ThrowsError() {
        XCTAssertThrowsError(try JSONDecoder().decode(Lesson.self, from: lessonDataMissingReadme)) { error in
            if case .keyNotFound(let key, _)? = error as? DecodingError {
                XCTAssertEqual("readme", key.stringValue)
            } else {
                XCTFail("Expected '.keyNotFound' for 'readme' but error was: \(error)")
            }
        }
    }
    
    func test_LessonInit_WithMissingIsCompleteAttr_SetsISCompleteAsFalse() throws {
        let sut = try JSONDecoder().decode(Lesson.self, from: lessonDataMissingIsComplete)
        
        XCTAssert(sut.isComplete == false, "Lesson '.isComplete' should be 'true' when not defined")
    }
    
    // MARK .complete()
    func test_LessonComplete_SetsIsCompleteAsTrue() throws {
        var sut = try JSONDecoder().decode(Lesson.self, from: lessonDataIsNotComplete)
        sut.complete()
        
        XCTAssertTrue(sut.isComplete, "Lesson '.isComplete' should be 'true' when lesson was completed")
    }
}

private let lessonDataMissingIsComplete = Data("""
{
    "id": 1,
    "slug": "functions",
    "title": "Functions",
    "readme": "test readme file"
}
""".utf8)

private let lessonDataMissingId = Data("""
{
    "slug": "functions",
    "title": "Functions",
    "readme": "test readme file"
}
""".utf8)

private let lessonDataMissingSlug = Data("""
{
    "id": 1,
    "title": "Functions",
    "readme": "test readme file"
}
""".utf8)

private let lessonDataMissingTitle = Data("""
{
    "id": 1,
    "slug": "functions",
    "readme": "test readme file"
}
""".utf8)

private let lessonDataMissingReadme = Data("""
{
    "id": 1,
    "slug": "functions",
    "title": "Functions"
}
""".utf8)

private let lessonDataIsNotComplete = Data("""
{
    "id": 1,
    "slug": "functions",
    "title": "Functions",
    "readme": "test readme file",
    "isNotComplete": false
}
""".utf8)
