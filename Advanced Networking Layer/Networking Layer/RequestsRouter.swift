//
//  RequestsRouter.swift
//  Advanced Networking Layer
//
//  Created by Ali Fayed on 12/11/2021.
//

import Foundation
import Alamofire

enum RequestsRouter {
  case usersList

  var baseURL: String {
    switch self {
    case .usersList:
      return "https://api.github.com"
    }
  }

  var path: String {
    switch self {
    case .usersList:
      return "/users"
    }
  }

  var method: HTTPMethod {
    switch self {
    case .usersList:
      return .get
    }
  }

  var parameters: [String: String]? {
    switch self {
    case .usersList:
      return nil
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
