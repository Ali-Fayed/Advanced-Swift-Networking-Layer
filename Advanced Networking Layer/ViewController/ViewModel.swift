//
//  ViewModel.swift
//  Advanced Networking Layer
//
//  Created by Ali Fayed on 12/11/2021.
//

import Foundation
import UIKit

class ViewModel {
    let useCases = UseCases.shared
    var newsList = [Post]()
    var newListCount: Int {
        return newsList.count
    }
    /// fetch data from use case
    func fetchNews() async -> (Result<[Post], Error>) {
        let results = await useCases.fetchNewsToViewModel()
        switch results {
        case .success(let model):
            newsList = model.hits
            return .success(model.hits)
        case .failure(let error):
            return .failure(error)
        }
    }
    /// handle error with alert
    func handleErrorWithAlert(message: String) async -> (UIAlertController) {
        let alert = await UIAlertController(title: "Error", message: message, preferredStyle: .alert)
        let action = await UIAlertAction(title: "OK", style: .default, handler: nil)
        await alert.addAction(action)
        return alert
    }
}
