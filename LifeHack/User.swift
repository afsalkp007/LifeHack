//
//  User.swift
//  LifeHack
//
//  Created by Afsal on 25/10/2024.
//

import Foundation

struct User: Equatable {
    let id: Int
    let reputation: Int
    var name: String
    var aboutMe: String?
    let profileImageURL: URL?
}
 
extension User {
    enum DecodingError: Error {
        case userDoesNotExist
    }
    
    init(from decoder: Decoder) throws {
        let container = try decoder.container(keyedBy: CodingKeys.self)
        let userType = try container.decode(String.self, forKey: .userType)
        guard userType != "does_not_exist" else {
            throw DecodingError.userDoesNotExist
        }
        id = try container.decode(Int.self, forKey: .id)
        reputation = try container.decode(Int.self, forKey: .reputation)
        name = try container.decode(String.self, forKey: .name)
        aboutMe = try container.decodeIfPresent(String.self, forKey: .aboutMe)
        profileImageURL = try container.decodeIfPresent(URL.self, forKey: .profileImageURL)
    }
}

extension User: Decodable {
    enum CodingKeys: String, CodingKey {
        case id = "user_id"
        case name = "display_name"
        case aboutMe = "about_me"
        case profileImageURL = "profile_image"
        case userType = "user_type"
        case reputation
    }
}

extension User {
    struct Wrapper: Decodable {
        let items: [User]

        enum CodingKeys: String, CodingKey {
            case items
        }
    }
}

