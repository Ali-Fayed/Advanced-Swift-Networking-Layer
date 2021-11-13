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
    /// fetch data from use case
    func fetchNews() async -> (Result<[Post], Error>) {
        let results = await useCases.fetchNews()
        switch results {
        case .success(let model):
            newsList = model
            return .success(model)
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
