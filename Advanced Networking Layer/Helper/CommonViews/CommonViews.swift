//
//  CommonViews.swift
//  Advanced Networking Layer
//
//  Created by Ali Fayed on 13/11/2021.
//

import UIKit
import SafariServices

class CommonViews {
    func showActivityIndicatorSpinner(spinner: UIActivityIndicatorView, view: UIView) {
        spinner.style = UIActivityIndicatorView.Style.large
        spinner.center = view.center
        spinner.startAnimating()
        view.addSubview(spinner)
    }
    func hideActivityIndicatorSpinner(spinner: UIActivityIndicatorView) {
        spinner.stopAnimating()
    }
    func showAlert(title: String, message: String, buttonTitle: String) async -> (UIAlertController) {
        let alert = await UIAlertController(title: title, message: message, preferredStyle: .alert)
        let action = await UIAlertAction(title: buttonTitle, style: .default, handler: nil)
        await alert.addAction(action)
        return alert
    }
    func presentURLinSafari(url: String, viewController: UIViewController) {
        let safariVC = SFSafariViewController(url: URL(string: url)!)
        viewController.present(safariVC, animated: true)
    }
    func showTableViewFooterSpinner(tableView: UITableView) {
        let spinner = UIActivityIndicatorView(style: .medium)
        spinner.startAnimating()
        spinner.frame = CGRect(x: CGFloat(0), y: CGFloat(0), width: tableView.bounds.width, height: CGFloat(44))
        tableView.tableFooterView = spinner
        tableView.tableFooterView?.isHidden = false
    }
    func hideTableViewFooterSpinner(tableView: UITableView) {
        tableView.tableFooterView = nil
    }
    func showLoadingIndicator(page: Int, spinner: UIActivityIndicatorView, view: UIView, tableView: UITableView) {
        page == 0
        ? showActivityIndicatorSpinner(spinner: spinner, view: view)
        : showTableViewFooterSpinner(tableView: tableView)
    }
    func hideLoadingIndicator(page: Int, spinner: UIActivityIndicatorView, view: UIView, tableView: UITableView) {
        page == 0
        ? hideActivityIndicatorSpinner(spinner: spinner)
        : hideTableViewFooterSpinner(tableView: tableView)
    }
}
