//
//  RouterManager.swift
//

import Foundation
import Alamofire

typealias APIParams = [String: Any]?
typealias APIHeaders = [String: String]?

protocol RouterConfig: URLRequestConvertible {
    
    var url: URL { get }
    
    var params: APIParams { get }
    
    var headers: APIHeaders { get }
    
    var method: HTTPMethod { get }
    
    var endPoint: String { get }
    
    var urlWithParams: String { get }
    
    var task: Task { get }
}

extension RouterConfig {
    
    var baseURL: String {
        return "https://api.github.com"
    }
    
    var url: URL {
        return URL(string: "\(baseURL)/\(endPoint)/\(urlWithParams)")!
    }
    
    var headers: APIHeaders {
        return ["Authorization": "\(APIManager.sharedInstance.accessToken)"]
    }
    
    var task: Task {
        return .request
    }
    
    func asURLRequest() throws -> URLRequest {
        
        var urlRequest = URLRequest(url: url)
        urlRequest.httpMethod = method.rawValue
        urlRequest.allHTTPHeaderFields = headers
        return try URLEncoding.default.encode(urlRequest, with: params)
    }
}

public enum Task {
    case request
    case download
    case upload
}

class RouterManager: URLRequestConvertible {
    
    var route: RouterConfig
    
    init(router: RouterConfig) {
        self.route = router
    }
    
    func getroute() -> RouterConfig {
        return route
    }
    
    func tipotask() -> Task {
        return getroute().task
    }
    
    func hasHeaders() -> Bool {
        return getHeaders() != nil
    }
    
    func getHeaders() -> APIHeaders {
        return getroute().headers
    }
    
    func getParams() -> APIParams {
        return getroute().params
    }
    
    func asURLRequest() throws -> URLRequest {
        return try getroute().asURLRequest()
    }
    
}
