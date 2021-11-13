//
//  EventsMonitor.swift
//  Advanced Networking Layer
//
//  Created by Ali Fayed on 12/11/2021.
//

import Foundation
import Alamofire

class EventsMonitor: EventMonitor {
  let queue = DispatchQueue(label: "com.Networking.Advanced-Networking-Layer")
    
  func requestDidFinish(_ request: Request) {
    print(request.description)
  }
    
  func request<Value>(_ request: DataRequest, didParseResponse response: DataResponse<Value, AFError>) {
    guard let data = response.data else {return}
    if let json = try? JSONSerialization.jsonObject(with: data, options: .mutableContainers) {
      print(json)
    }
  }
}
