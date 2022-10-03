//
//  Constants.swift
//  Navi Assessment
//
//  Created by Madhvendra raj singh on 03/10/22.
//

import Foundation

struct Constant {
    struct ProductionServer {
        static let baseURL = "https://api.github.com"
    }
    
    struct APIParameterKey {
        static let password = "password"
        static let email = "email"
    }
}

enum HTTPHeaderField: String {
    case authentication = "Authorization"
    case contentType = "Content-Type"
    case acceptType = "Accept"
    case acceptEncoding = "Accept-Encoding"
}

enum ContentType: String {
    case json = "application/json"
}
