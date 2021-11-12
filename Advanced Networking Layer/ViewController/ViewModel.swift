//
//  ViewModel.swift
//  Advanced Networking Layer
//
//  Created by Ali Fayed on 12/11/2021.
//

import Foundation
import UIKit

class ViewModel {
    var errorString: String?
    var usersList = [GithubUsers]() 
    // fetch data from use case
    func fetchUsers(completion: @escaping () -> ()) {
        UseCases.shared.fetchUsers { [weak self] result in
            switch result {
            case .success(let model):
                self?.usersList = model
                completion()
            case .failure(let error):
                self?.errorString = error.localizedDescription
            }
        }
    }
    // handle error with alert
    func handleErrorWithAlert(message: String, completion: @escaping (UIAlertController) -> ()) {
        let alert = UIAlertController(title: "Error", message: message, preferredStyle: .alert)
        let action = UIAlertAction(title: "OK", style: .default, handler: nil)
        alert.addAction(action)
        completion(alert)
    }
}
