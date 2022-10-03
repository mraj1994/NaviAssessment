//
//  APIManager.swift
//  Navi Assessment
//
//  Created by Madhvendra raj singh on 03/10/22.
//

import Foundation

import Alamofire


//This class manages api call
class APIManager {
    @discardableResult
    private static func performRequest<T:Decodable>(route:APIRouter, decoder: JSONDecoder = JSONDecoder(), completion:@escaping (Result<T, AFError>)->Void) -> DataRequest {
        return AF.request(route)
            .responseDecodable (decoder: decoder){ (response: DataResponse<T, AFError>) in
                completion(response.result)
            }
    }
    
    static func getPullRequest(state: String, pageNumber: Int,itemsPerPage:Int, completion:@escaping (Result<[PullRequestResponseModel], AFError>)->Void) {
        let jsonDecoder = JSONDecoder()
        performRequest(route: APIRouter.pullRequest(state: state, pageNumber: pageNumber, itemsPerPage: itemsPerPage), decoder: jsonDecoder, completion: completion)
    }
}

