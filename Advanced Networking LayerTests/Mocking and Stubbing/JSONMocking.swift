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
        "hits" : [],
        "nbHits": 27112861,
        "page": 0,
        "nbPages": 50,
        "hitsPerPage": 20,
        "exhaustiveNbHits": true,
        "exhaustiveTypo": true,
        "query": "",
        "params": "advancedSyntax=true&analytics=true&analyticsTags=backend",
        "renderingContent": [],
        "processingTimeMS": 50
    ]
}
