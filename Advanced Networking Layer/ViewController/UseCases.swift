//
//  UseCases.swift
//  Advanced Networking Layer
//
//  Created by Ali Fayed on 12/11/2021.
//

import Foundation
import Alamofire

protocol ViewControllerUseCase {
    func fetchUsers(completionHandler: @escaping (Result<[GithubUsers], Error>) -> Void)
}
class UseCases: ViewControllerUseCase {
    static let shared = UseCases()
    private init () {}
    func fetchUsers(completionHandler: @escaping (Result<[GithubUsers], Error>) -> Void) {
        NetworkingManger.shared.performRequest(model: [GithubUsers].self, requestRouter: RequestsRouter.usersList) { result in
            switch result {
            case .success(let model):
                completionHandler(.success(model))
            case .failure(let error):
                completionHandler(.failure(error))
            }
        }
    }
}
