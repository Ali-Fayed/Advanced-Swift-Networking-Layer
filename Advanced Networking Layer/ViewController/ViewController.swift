//
//  ViewController.swift
//  Advanced Networking Layer
//
//  Created by Ali Fayed on 12/11/2021.
//

import UIKit

class ViewController: UIViewController {
    @IBOutlet weak var tableView: UITableView!
    lazy var viewModel = ViewModel()
    override func viewDidLoad() {
        super.viewDidLoad()
        fetchViewData()
    }
    func fetchViewData () {
        // fetch users
        viewModel.fetchUsers { [weak self] in
            self?.tableView.reloadData()
        }
        // handle error with alert
        if let errorMsg = viewModel.errorString {
            viewModel.handleErrorWithAlert(message: errorMsg) { [weak self] alert in
                self?.present(alert, animated: true)
            }
        }
    }
}

//MARK: - tableView
extension ViewController: UITableViewDataSource, UITableViewDelegate {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        viewModel.usersList.count
    }
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "cell", for: indexPath)
        cell.textLabel?.text = viewModel.usersList[indexPath.row].userName.uppercased()
        return cell
    }
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        tableView.deselectRow(at: indexPath, animated: true)
    }
}
