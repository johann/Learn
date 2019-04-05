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
    var apiBase: String {
        get {
            return Constants.localHost
        }
    }
    
    var path: String {
        switch self {
        case .profile:
            return "/api/profiles/me"
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
