//
//  RequestsInterceptor.swift
//  Advanced Networking Layer
//
//  Created by Ali Fayed on 12/11/2021.
//

import Foundation
import Alamofire

class RequestsInterceptor: RequestInterceptor {
  let retryLimit = 5
  let retryDelay: TimeInterval = 10

  func adapt(_ urlRequest: URLRequest, for session: Session, completion: @escaping (Result<URLRequest, Error>) -> Void) {
      /// put your token here if you have an application with authentication the adapt function from alamofire help you attach your token with any request
      /*
       example :-
       var urlRequest = urlRequest
       if let token = TokenManager.shared.fetchAccessToken() {
         urlRequest.setValue("token \(token)", forHTTPHeaderField: "Authorization")
       }
        */
    completion(.success(urlRequest))
  }

  func retry(_ request: Request, for session: Session, dueTo error: Error, completion: @escaping (RetryResult) -> Void) {
    let response = request.task?.response as? HTTPURLResponse
    //Retry the request for 5xx status codes
    if
      let statusCode = response?.statusCode,
      (500...599).contains(statusCode),
      request.retryCount < retryLimit {
        completion(.retryWithDelay(retryDelay))
    } else {
      return completion(.doNotRetry)
    }
  }
}
