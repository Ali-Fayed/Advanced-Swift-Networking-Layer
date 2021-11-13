//
//  Model.swift
//  Advanced Networking Layer
//
//  Created by Ali Fayed on 12/11/2021.
//

import Foundation

struct Results: Decodable {
    let hits: [Post]
}

struct Post {
    let postTitle: String

    enum PostCodingKeys: String, CodingKey {
        case postTitle = "title"
    }
}
extension Post: Decodable {
    init(from decoder: Decoder) throws {
        let container = try decoder.container(keyedBy: PostCodingKeys.self)
        postTitle = try container.decode(String.self, forKey: .postTitle)
    }
}
