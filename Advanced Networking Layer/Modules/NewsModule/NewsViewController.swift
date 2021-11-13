//
//  ViewController.swift
//  Advanced Networking Layer
//
//  Created by Ali Fayed on 12/11/2021.
//

import UIKit

class NewsViewController: UIViewController {
    @IBOutlet weak var tableView: UITableView!
    private let spinner = UIActivityIndicatorView()
    private let viewModel = NewsViewModel()
    private let commonViews = CommonViews()
    //MARK: - LifeCycle
    override func viewDidLoad() {
        super.viewDidLoad()
        fetchViewControllerData()
    }
    //MARK: - Methods
    private func fetchViewControllerData () {
        Task.init {
        commonViews.showActivityIndicator(spinner: spinner, view: view)
        let result = await viewModel.fetchNews()
            switch result {
            case .success(_):
                    tableView.reloadData()
                    commonViews.hideActivityIndicator(spinner: spinner)
            case .failure(let error):
                let alert = await commonViews.showAlert(
                    title: "Error",
                    message: error.localizedDescription,
                    buttonTitle: "Ok")
                    present(alert, animated: true)
            }
        }
    }
}
     //MARK: - tableView
extension NewsViewController: UITableViewDataSource, UITableViewDelegate {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        viewModel.newListCount
    }
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "cell", for: indexPath)
        cell.textLabel?.text = viewModel.newsList[indexPath.row].postTitle
        cell.detailTextLabel?.text = viewModel.newsList[indexPath.row].postAuthor
        return cell
    }
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        tableView.deselectRow(at: indexPath, animated: true)
        let url = viewModel.newsList[indexPath.row].postURL
        commonViews.presentURLinSafari(url: url, viewController: self)
    }
}
