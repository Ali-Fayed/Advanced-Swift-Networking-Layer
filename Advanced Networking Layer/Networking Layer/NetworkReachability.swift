//
//  NetworkReachability.swift
//  Advanced Networking Layer
//
//  Created by Ali Fayed on 12/11/2021.
//

import UIKit
import Alamofire

class NetworkReachability {
  static let shared = NetworkReachability()
  let reachabilityManager = NetworkReachabilityManager(host: "www.google.com")
  let offlineAlertController: UIAlertController = {
    UIAlertController(title: "No Network", message: "Please connect to network and try again", preferredStyle: .alert)
  }()

  func startNetworkMonitoring() {
    reachabilityManager?.startListening { status in
      switch status {
      case .notReachable:
        self.showOfflineAlert()
      case .reachable(.cellular):
        self.dismissOfflineAlert()
      case .reachable(.ethernetOrWiFi):
        self.dismissOfflineAlert()
      case .unknown:
        print("Unknown network state")
      }
    }
  }

  func showOfflineAlert() {
    let rootViewController = UIApplication.shared.windows.first?.rootViewController
    rootViewController?.present(offlineAlertController, animated: true, completion: nil)
  }

  func dismissOfflineAlert() {
    let rootViewController = UIApplication.shared.windows.first?.rootViewController
    rootViewController?.dismiss(animated: true, completion: nil)
  }
}
