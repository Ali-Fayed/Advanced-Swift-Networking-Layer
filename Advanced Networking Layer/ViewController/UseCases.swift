//
//  UseCases.swift
//  Advanced Networking Layer
//
//  Created by Ali Fayed on 12/11/2021.
//

import Foundation
import Alamofire

protocol ViewControllerUseCase {
    func fetchNewsToViewModel() async -> (Result<Results, Error>)
}

class UseCases: ViewControllerUseCase {
    static let shared = UseCases()
    let networingManger = NetworkingManger.shared
    private init () {}
    func fetchNewsToViewModel () async -> (Result<Results, Error>) {
        await withUnsafeContinuation({ continuation in
            Task.init {
                let model = Results.self
                let router = RequestsRouter.newsList
                let result = await networingManger.performRequest(model: model, requestRouter: router)
                switch result {
                case .success(let model):
                    continuation.resume(returning: .success(model))
                case .failure(let error):
                    continuation.resume(returning: .failure(error))
                }
            }
        })
    }
}
