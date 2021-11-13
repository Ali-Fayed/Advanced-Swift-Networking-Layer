//
//  CommonViews.swift
//  Advanced Networking Layer
//
//  Created by Ali Fayed on 13/11/2021.
//

import UIKit
import SafariServices

class CommonViews {
    func showActivityIndicator(spinner: UIActivityIndicatorView, view: UIView) {
        spinner.style = UIActivityIndicatorView.Style.large
        spinner.center = view.center
        spinner.startAnimating()
        view.addSubview(spinner)
    }
    func hideActivityIndicator(spinner: UIActivityIndicatorView) {
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
}
