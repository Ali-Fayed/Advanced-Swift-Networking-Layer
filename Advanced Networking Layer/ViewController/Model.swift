//
//  Model.swift
//  Advanced Networking Layer
//
//  Created by Ali Fayed on 12/11/2021.
//

import Foundation

struct GithubUsers {
    let userName: String
    
    enum CodingKeys: String, CodingKey {
        case userName = "login"
    }
}
extension GithubUsers: Decodable {
    init(from decoder: Decoder) throws {
        let container = try decoder.container(keyedBy: CodingKeys.self)
        userName = try container.decode(String.self, forKey: .userName)
    }
}
