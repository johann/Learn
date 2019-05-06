//
//  NetworkError.swift
//  Learn
//
//  Created by Luke Ghenco on 5/5/19.
//  Copyright © 2019 Johann Kerr. All rights reserved.
//
import Foundation

enum NetworkError: Error {
    case urlFailure
    case missingData
    case malformedJSON
    case jsonError
}
