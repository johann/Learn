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
    var apiBase: String {
        get {
            return Constants.localHost
        }
    }
    
    var path: String {
        switch self {
        case .profile:
            return "/api/profiles/me"
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
