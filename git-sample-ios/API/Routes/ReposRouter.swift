//
//  Router.swift
//

import Foundation
import Alamofire

enum ReposRouter: RouterConfig {
    
    case getRepos(text: String, page: Int)
    case getPulls(owner: String, repo: String)
    
    var endPoint: String {
        switch self {
        case .getRepos:
            return "search"
        case .getPulls:
            return "repos"
        }
    }
    
    var method: HTTPMethod {
        return .get
    }
    
    var urlWithParams: String {
        switch self {
        case .getRepos(let text, let page):
            return "repositories?q=\(text)+language:Swift&sort=stars&page=\(page)"
        case .getPulls(let owner, let repo):
            return "\(owner)/\(repo)/pulls"
        }
    }
    
    var params: APIParams {
        return nil
    }
    
    var headers: APIHeaders {
        return [
            "Content-Type": "application/json; charset=UTF-8"
        ]
        
    }
    
}
