//
//  ViewController.swift
//  Advanced Networking Layer
//
//  Created by Ali Fayed on 12/11/2021.
//

import UIKit

class ViewController: UIViewController {
    @IBOutlet weak var tableView: UITableView!
    private let activityIndicator = UIActivityIndicatorView(style: .medium)
    private let viewModel = ViewModel()
    override func viewDidLoad() {
        super.viewDidLoad()
        fetchViewControllerData()
        configActivityIndicator()
    }
    private func configActivityIndicator() {
        activityIndicator.style = UIActivityIndicatorView.Style.large
        activityIndicator.center = view.center
        view.addSubview(activityIndicator)
    }
    private func fetchViewControllerData () {
        Task.init {
        activityIndicator.startAnimating()
        let result = await viewModel.fetchNews()
            switch result {
            case .success(_):
                tableView.reloadData()
                activityIndicator.stopAnimating()
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
        viewModel.newListCount
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
