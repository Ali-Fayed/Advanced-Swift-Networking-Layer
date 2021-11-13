//
//  Protocols.swift
//  Advanced Networking Layer
//
//  Created by Ali Fayed on 13/11/2021.
//

import Foundation
import UIKit

//MARK: - UseCases
protocol NewsViewUseCaseProtocol {
    func fetchNewsToViewModel(page: Int, perPage: Int, query: String) async -> (Result<NewsResults, Error>)
}
//MARK: - ViewModel
protocol NewsViewModelProtocol {
    func fetchNews() async -> (Result<[Post], Error>)
}
