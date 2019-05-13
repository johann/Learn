//
//  AdaptersTestData.swift
//  LearnTests
//
//  Created by Luke Ghenco on 5/13/19.
//  Copyright © 2019 Johann Kerr. All rights reserved.
//
import Foundation

struct AdaptersTestData {
    static let unsuccessfulLearnAPIProfileJSON = "{}"
    static let successfulLearnAPIProfileJSON = """
        {
            "gravatar_url": "https://avatars.githubusercontent.com/u/123456",
            "learn_uuid": "111-222-333",
            "display_name": "Flint Lockwood",
            "completed_lessons_count": 0,
            "total_lessons_count": 4,
            "email": "test@gmail.com",
            "id": 26,
            "velocity": 0,
            "last_seen_at": "2019-03-12 01:18:01",
            "learn_username": "steadfast-delimiter-7257",
            "active_track": {
                "id": 1,
                "slug": "intro-to-data-science",
                "title": "Intro to Data Science",
                "uuid": "aaa-bbb-ccc",
            },
            "active_batch": {
                "display_name": "Online DS SP-000",
                "id": 11,
                "iteration": "online-ds-sp-000",
                "uuid": "111-aaa-222"
            },
            "active_course": {
                "display_name": "Online Data Science Bootcamp",
                "id": 15,
                "slug": "online-data-science-bootcamp",
                "uuid": "aaa-111-bbb",
            }
        }
    """
    
    static let successfulLearnAPITrackJSON = """
        {
            "id": 1,
            "slug": "intro-to-data-science",
            "title": "Intro to Data Science",
            "uuid": "111-222-333",
            "topics": [
                {
                    "id": 2,
                    "slug": "regression",
                    "title": "Regression",
                    "units": [
                        {
                            "id": 3,
                            "slug": "least-squares-regression",
                            "title": "Least Squares Regression",
                            "lessons": [
                                {
                                    "id": 4,
                                    "readme": "Readme for Least Squares Regression",
                                    "slug": "what-is-a-least-squares-regression",
                                    "title": "What is a least squares regression?"
                                }
                            ]
                        }
                    ]
                }
            ]
        }
    """
}
