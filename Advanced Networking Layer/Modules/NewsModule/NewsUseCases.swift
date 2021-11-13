//
//  UseCases.swift
//  Advanced Networking Layer
//
//  Created by Ali Fayed on 12/11/2021.
//

import Foundation
import Alamofire

class NewsUseCases: NewsViewUseCaseProtocol {
    static let shared = NewsUseCases()
    let networingManger = NetworkingManger.shared
    private init () {}
    //MARK: - Methods
    func fetchNewsToViewModel() async -> (Result<Results, Error>) {
        await withUnsafeContinuation({ continuation in
            Task.init {
                let result = await networingManger.performRequest(
                    model: Results.self,
                    requestRouter: RequestsRouter.newsList)
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
