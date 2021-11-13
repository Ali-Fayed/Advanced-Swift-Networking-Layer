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
    private let networingManger = NetworkingManger.shared
    private init () {}
    //MARK: - Methods
    func fetchNewsToViewModel(page: Int, perPage: Int, query: String) async -> (Result<NewsResults, Error>) {
        await withUnsafeContinuation({ continuation in
            Task.init {
                let result = await networingManger.performRequest(
                    model: NewsResults.self,
                    requestRouter: RequestsRouter.newsList(page: page, query: query, perPage: perPage))
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
