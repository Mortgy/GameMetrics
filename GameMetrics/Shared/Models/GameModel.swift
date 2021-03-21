//
//  GameModel.swift
//  GameMetrics
//
//  Created by Mortgy on 3/19/21.
//

import Foundation

// MARK: - GameResponseModel
struct GameResponseModel: Codable {
    let count: Int?
    let next: String?
    let previous: String?
    let results: [GameModel]?
    let userPlatforms: Bool?

    enum CodingKeys: String, CodingKey {
        case count = "count"
        case next = "next"
        case previous = "previous"
        case results = "results"
        case userPlatforms = "user_platforms"
    }
}

// MARK: - Result
struct GameModel: Codable {
    let slug: String?
    let name: String?
    let playtime: Int?
    let platforms: [Platform]?
    let stores: [Store]?
    let released: String?
    let tba: Bool?
    let backgroundImage: String?
    let rating: Double?
    let ratingTop: Int?
    let ratings: [Rating]?
    let ratingsCount: Int?
    let reviewsTextCount: Int?
    let added: Int?
    let addedByStatus: AddedByStatus?
    let metacritic: Int?
    let suggestionsCount: Int?
    let updated: String?
    let id: Int
    let score: String?
    let clip: String?
    let tags: [Tag]?
    let esrbRating: EsrbRating?
    let userGame: String?
    let reviewsCount: Int?
    let saturatedColor: String?
    let dominantColor: String?
    let shortScreenshots: [ShortScreenshot]?
    let parentPlatforms: [Platform]?
    let genres: [Genre]?
    let communityRating: Int?

    enum CodingKeys: String, CodingKey {
        case slug = "slug"
        case name = "name"
        case playtime = "playtime"
        case platforms = "platforms"
        case stores = "stores"
        case released = "released"
        case tba = "tba"
        case backgroundImage = "background_image"
        case rating = "rating"
        case ratingTop = "rating_top"
        case ratings = "ratings"
        case ratingsCount = "ratings_count"
        case reviewsTextCount = "reviews_text_count"
        case added = "added"
        case addedByStatus = "added_by_status"
        case metacritic = "metacritic"
        case suggestionsCount = "suggestions_count"
        case updated = "updated"
        case id = "id"
        case score = "score"
        case clip = "clip"
        case tags = "tags"
        case esrbRating = "esrb_rating"
        case userGame = "user_game"
        case reviewsCount = "reviews_count"
        case saturatedColor = "saturated_color"
        case dominantColor = "dominant_color"
        case shortScreenshots = "short_screenshots"
        case parentPlatforms = "parent_platforms"
        case genres = "genres"
        case communityRating = "community_rating"
    }
}

// MARK: - AddedByStatus
struct AddedByStatus: Codable {
    let yet: Int?
    let owned: Int?
    let beaten: Int?
    let toplay: Int?
    let dropped: Int?
    let playing: Int?

    enum CodingKeys: String, CodingKey {
        case yet = "yet"
        case owned = "owned"
        case beaten = "beaten"
        case toplay = "toplay"
        case dropped = "dropped"
        case playing = "playing"
    }
}

// MARK: - EsrbRating
struct EsrbRating: Codable {
    let id: Int?
    let name: String?
    let slug: String?

    enum CodingKeys: String, CodingKey {
        case id = "id"
        case name = "name"
        case slug = "slug"
    }
}

// MARK: - Genre
struct Genre: Codable {
    let id: Int
    let name: String
    let slug: String

    enum CodingKeys: String, CodingKey {
        case id = "id"
        case name = "name"
        case slug = "slug"
    }
}

// MARK: - Platform
struct Platform: Codable {
    let platform: Genre?

    enum CodingKeys: String, CodingKey {
        case platform = "platform"
    }
}

// MARK: - Rating
struct Rating: Codable {
    let id: Int?
    let title: String?
    let count: Int?
    let percent: Double?

    enum CodingKeys: String, CodingKey {
        case id = "id"
        case title = "title"
        case count = "count"
        case percent = "percent"
    }
}

// MARK: - ShortScreenshot
struct ShortScreenshot: Codable {
    let id: Int?
    let image: String?

    enum CodingKeys: String, CodingKey {
        case id = "id"
        case image = "image"
    }
}

// MARK: - Store
struct Store: Codable {
    let store: Genre?

    enum CodingKeys: String, CodingKey {
        case store = "store"
    }
}

// MARK: - Tag
struct Tag: Codable {
    let id: Int?
    let name: String?
    let slug: String?
    let language: String?
    let gamesCount: Int?
    let imageBackground: String?

    enum CodingKeys: String, CodingKey {
        case id = "id"
        case name = "name"
        case slug = "slug"
        case language = "language"
        case gamesCount = "games_count"
        case imageBackground = "image_background"
    }
}
