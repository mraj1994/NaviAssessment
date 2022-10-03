//
//  APIRouter.swift
//  Navi Assessment
//
//  Created by Madhvendra raj singh on 03/10/22.
//

import Foundation
import Alamofire

enum APIRouter: URLRequestConvertible {
    
    
    case pullRequest(state: String,pageNumber: Int, itemsPerPage: Int)
    
    // MARK: - HTTPMethod
    private var method: HTTPMethod {
        switch self {
        case .pullRequest:
            return .get
        }
    }
    
    // MARK: - Path
    private var path: String {
        switch self {
        case .pullRequest:
            return "/repos/apple/swift/pulls"
        }
    }
    
    // MARK: - Parameters
    private var parameters: Parameters? {
        switch self {
        case .pullRequest:
           return nil
        }
    }
    
    var urlQueryParameters: [URLQueryItem]? {
        switch self {
        case .pullRequest(let state, let pageNumber, let itemsPerPage):
            var items = [URLQueryItem]()
            items.append(URLQueryItem(name: "page", value: "\(pageNumber)"))
            items.append(URLQueryItem(name: "state", value: "\(state)"))
            items.append(URLQueryItem(name: "per_page", value: "\(itemsPerPage)"))
            return items
        }
    }

    
    // MARK: - URLRequestConvertible
    func asURLRequest() throws -> URLRequest {
        let urlString = Constant.ProductionServer.baseURL
        var urlComponents = URLComponents(string: urlString)!
        urlComponents.queryItems = urlQueryParameters
        let url = urlComponents.url!
        
        var urlRequest = URLRequest(url: url.appendingPathComponent(path))
        print(urlRequest.url?.absoluteString)
        // HTTP Method
        urlRequest.httpMethod = method.rawValue
        
        // Common Headers
        urlRequest.setValue(ContentType.json.rawValue, forHTTPHeaderField: HTTPHeaderField.acceptType.rawValue)
        urlRequest.setValue(ContentType.json.rawValue, forHTTPHeaderField: HTTPHeaderField.contentType.rawValue)
        
        // Parameters
        if let parameters = parameters {
            do {
                urlRequest.httpBody = try JSONSerialization.data(withJSONObject: parameters, options: [])
            } catch {
                throw AFError.parameterEncodingFailed(reason: .jsonEncodingFailed(error: error))
            }
        }

        return urlRequest
    }
    
}
