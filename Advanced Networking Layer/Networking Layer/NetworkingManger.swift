//
//  NetworkingManger.swift
//  Advanced Networking Layer
//
//  Created by Ali Fayed on 12/11/2021.
//

import Foundation
import Alamofire

class NetworkingManger {
    static let shared = NetworkingManger()
    // af session attach the cached requests, interceptor and event logger to any request we do it
    let afSession: Session = {
        let configuration = URLSessionConfiguration.af.default
        configuration.requestCachePolicy = .returnCacheDataElseLoad
        let responseCacher = ResponseCacher(behavior: .modify { _, response in
            let userInfo = ["date": Date()]
            return CachedURLResponse(
                response: response.response,
                data: response.data,
                userInfo: userInfo,
                storagePolicy: .allowed)
        })
        let eventsMonitor = EventsMonitor()
        let RequestsInterceptor = RequestsInterceptor()
        return Session(
            configuration: configuration,
            interceptor: RequestsInterceptor,
            cachedResponseHandler: responseCacher,
            eventMonitors: [eventsMonitor])
    }()
    //MARK: - Main Function
    /// generic function take a model and router to perfrom a networking request
    func performRequest<T: Decodable>(model: T.Type, requestRouter: URLRequestConvertible) async -> (Result<T, Error>) {
        await withUnsafeContinuation({ continuation in
            self.afSession.request(requestRouter)
                .validate(statusCode: 200...300)
                .responseDecodable(of: T.self, completionHandler: { response in
                    switch response.result {
                    case .success(_):
                        guard let value = response.value else {return}
                        continuation.resume(returning: .success(value))
                    case .failure(let error):
                        continuation.resume(returning: .failure(error))
                    }
                })
        })
    }
}
