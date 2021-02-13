//
//  File.swift
//  ortiz-Koombea-fit
//
//  Created by edgar david ortiz diaz on 12/02/21.
//

import Foundation

// MARK: - PhotosListModel
struct PhotosListModel: Codable {
    let data: [Datum]?
}

// MARK: - Datum
struct Datum: Codable {
    let uid, name, email: String?
    let profilePic: String?
    let post: Post?

    enum CodingKeys: String, CodingKey {
        case uid, name, email
        case profilePic = "profile_pic"
        case post
    }
}

// MARK: - Post
struct Post: Codable {
    let id: Int?
    let date: String?
    let pics: [String]?
}
