//
//  RequestsRouter.swift
//  Advanced Networking Layer
//
//  Created by Ali Fayed on 12/11/2021.
//

import Foundation
import Alamofire

enum RequestsRouter {
    case newsList(page: Int, query: String, perPage: Int)
    var baseURL: String {
        switch self {
        case .newsList:
            return "https://hn.algolia.com"
        }
    }
    var path: String {
        switch self {
        case .newsList:
            return "/api/v1/search"
        }
    }
    var method: HTTPMethod {
        switch self {
        case .newsList:
            return .get
        }
    }
    var parameters: [String: String]? {
        switch self {
        case .newsList(let page, let query, let perPage):
            return [
                "query": query,
                "hitsPerPage": "\(perPage)",
                "tags": "story",
                "page": "\(page)"
            ]
        }
    }
}
// MARK: - URLRequestConvertible
extension RequestsRouter: URLRequestConvertible {
  func asURLRequest() throws -> URLRequest {
    let url = try baseURL.asURL().appendingPathComponent(path)
    var request = URLRequest(url: url)
    request.method = method
    if method == .get {
      request = try URLEncodedFormParameterEncoder()
        .encode(parameters, into: request)
    } else if method == .post {
      request = try JSONParameterEncoder().encode(parameters, into: request)
    }
    return request
  }
}
