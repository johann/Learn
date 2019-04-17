//
//  Endpoint.swift
//  Learn
//
//  Created by Johann Kerr on 4/3/19.
//  Copyright © 2019 Johann Kerr. All rights reserved.
//

import Foundation

public enum Endpoint {
    case profile
    case lesson(String, String, String)
    case curriculum(Int, Int, Int)
    var apiBase: String {
        get {
            return Constants.qaLearnHost
        }
    }
    
    var path: String {
        switch self {
        case .profile:
            return "/api/profiles/me"
        case .curriculum(let userId, let batchId, let trackId):
            return "/api/users/\(userId)/track_hierarchy?batch_id=\(batchId)&track_id=\(trackId)"
        case .lesson(let userId, let batchId, let trackId):
            return "/api/users/\(userId)/lessons?batch_id=\(batchId)&track_id=\(trackId)"
        }
    }
    
    func url() -> URL? {
        var components = URLComponents()
        components.scheme = "https"
        components.host = self.apiBase
        components.path = self.path
       
        return components.url
    }
}
