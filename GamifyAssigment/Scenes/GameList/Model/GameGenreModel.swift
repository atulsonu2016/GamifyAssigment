//
//  GameGenreModel.swift
//  Assigment
//
//  Created by Atul Sharan on 25/02/24.
//

import Foundation

// MARK: - Welcome
struct GameGenreModel: Codable {
    let count: Int?
    let next, previous: String?
    let results: [GameGenre]?
}

// MARK: - Result
struct GameGenre: Codable {
    let id: Int?
    let name, slug: String?
    let gamesCount: Int?
    let imageBackground: String?
    
    enum CodingKeys: String, CodingKey {
        case id, name, slug
        case gamesCount = "games_count"
        case imageBackground = "image_background"
    }
}

