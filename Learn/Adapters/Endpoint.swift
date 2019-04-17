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
        case .curriculum(let userId, _, _):
            return "/api/users/\(userId)/track_hierarchy"
        case .lesson(let userId, let batchId, let trackId):
            return "/api/users/\(userId)/lessons?batch_id=\(batchId)&track_id=\(trackId)"
        }
    }

    var queryItems: [URLQueryItem] {
        switch self {
        case.curriculum(_, let batchId, let trackId):
            let queryItemBatchId = URLQueryItem(name: "batch_id", value: ("\(batchId)"))
            let queryItemTrackId = URLQueryItem(name: "track_id", value: ("\(trackId)"))
            
            return [queryItemBatchId, queryItemTrackId]
        default:
            return []
        }
    }
    
    
    func url() -> URL? {
        var components = URLComponents()
        components.scheme = "https"
        components.host = self.apiBase
        components.path = self.path
        components.queryItems = self.queryItems
       
        return components.url
    }
}
