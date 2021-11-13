//
//  Model.swift
//  Advanced Networking Layer
//
//  Created by Ali Fayed on 12/11/2021.
//

import Foundation

//MARK: - ResultsModel
struct Results: Decodable {
    let hits: [Post]
}
//MARK: - PostsModel
struct Post {
    let postTitle: String
    let postAuthor: String
    let postURL: String

    enum PostCodingKeys: String, CodingKey {
        case postTitle = "title"
        case postAuthor = "author"
        case postURL = "url"
    }
}
//MARK: - Decodable init
extension Post: Decodable {
    init(from decoder: Decoder) throws {
        let container = try decoder.container(keyedBy: PostCodingKeys.self)
        postTitle = try container.decode(String.self, forKey: .postTitle)
        postAuthor = try container.decode(String.self, forKey: .postAuthor)
        postURL = try container.decode(String.self, forKey: .postURL)
    }
}
