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
    //MARK: - View LifeCycle
    override func viewDidLoad() {
        super.viewDidLoad()
        fetchViewControllerData()
    }
    //MARK: - Data Fetching Methods
    private func fetchViewControllerData () {
        Task.init {
        showLoadingIndicator ()
        let result = await viewModel.fetchNews()
        switch result {
            case .success(_):
                    tableView.reloadData()
                    hideLoadingIndicator()
            case .failure(let error):
                let alert = await commonViews.showAlert(
                    title: "Error",
                    message: error.localizedDescription,
                    buttonTitle: "Ok")
                    present(alert, animated: true)
            }
        }
    }
    //MARK: - FirstRequest and Paging Request Loading Indicator
    func showLoadingIndicator() {
        commonViews.showLoadingIndicator(page: viewModel.page, spinner: spinner, view: view, tableView: tableView)
    }
    func hideLoadingIndicator() {
        commonViews.hideLoadingIndicator(page: viewModel.page, spinner: spinner, view: view, tableView: tableView)
    }
}
     //MARK: - TableView Methods
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
        guard let url = viewModel.newsList[indexPath.row].postURL else {return}
        commonViews.presentURLinSafari(url: url, viewController: self)
    }
    func tableView(_ tableView: UITableView, willDisplay cell: UITableViewCell, forRowAt indexPath: IndexPath) {
        viewModel.loadMoreNews(indexPathRow: indexPath.row) { [weak self] in
            self?.fetchViewControllerData()
        }
    }
}
