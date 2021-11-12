//
//  JSONMocking.swift
//  Advanced Networking LayerTests
//
//  Created by Ali Fayed on 12/11/2021.
//

import Foundation

class JSONMocking {
    static let shared = JSONMocking()
    private init() {}
    let fakeJSON: [String: Any] = [
        "login": "mojombo"
    ]
}
