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
        Task.init {
        let result = await viewModel.fetchNews()
            switch result {
            case .success(_):
                tableView.reloadData()
            case .failure(let error):
                let alert = await viewModel.handleErrorWithAlert(message: error.localizedDescription)
                present(alert, animated: true)
            }
        }
    }
}
//MARK: - tableView
extension ViewController: UITableViewDataSource, UITableViewDelegate {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        viewModel.newsList.count
    }
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "cell", for: indexPath)
        cell.textLabel?.text = viewModel.newsList[indexPath.row].postTitle
        return cell
    }
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        tableView.deselectRow(at: indexPath, animated: true)
    }
}
