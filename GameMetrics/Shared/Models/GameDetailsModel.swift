//
//  GameDetailsModel.swift
//  GameMetrics
//
//  Created by Mortgy on 3/19/21.
//

import Foundation

// MARK: - GameDetailsModel
struct GameDetailsModel: Codable {
    let id: Int
    let slug: String?
    let name: String?
    let nameOriginal: String?
    let gameDetailsModelDescription: String?
    let metacritic: Int?
    let metacriticPlatforms: [MetacriticPlatform]?
    let released: String?
    let tba: Bool?
    let updated: String?
    let backgroundImage: String?
    let backgroundImageAdditional: String?
    let website: String?
    let rating: Double?
    let ratingTop: Int?
    let ratings: [Rating]?
    let reactions: [String: Int]?
    let added: Int?
    let addedByStatus: AddedByStatus?
    let playtime: Int?
    let screenshotsCount: Int?
    let moviesCount: Int?
    let creatorsCount: Int?
    let achievementsCount: Int?
    let parentAchievementsCount: Int?
    let redditUrl: String?
    let redditName: String?
    let redditDescription: String?
    let redditLogo: String?
    let redditCount: Int?
    let twitchCount: Int?
    let youtubeCount: Int?
    let reviewsTextCount: Int?
    let ratingsCount: Int?
    let suggestionsCount: Int?
    let alternativeNames: [String]?
    let metacriticUrl: String?
    let parentsCount: Int?
    let additionsCount: Int?
    let gameSeriesCount: Int?
    let userGame: String?
    let reviewsCount: Int?
    let saturatedColor: String?
    let dominantColor: String?
    let parentPlatforms: [ParentPlatform]?
    let platforms: [PlatformElement]?
    let stores: [StoreDetails]?
    let developers: [Developer]?
    let genres: [Developer]?
    let tags: [Developer]?
    let publishers: [Developer]?
    let esrbRating: EsrbRating?
    let clip: Clip?
    let descriptionRaw: String?

    var detailCacheId: String {
        return "detailCacheId\(id)"
    }
    
    enum CodingKeys: String, CodingKey {
        case id = "id"
        case slug = "slug"
        case name = "name"
        case nameOriginal = "name_original"
        case gameDetailsModelDescription = "description"
        case metacritic = "metacritic"
        case metacriticPlatforms = "metacritic_platforms"
        case released = "released"
        case tba = "tba"
        case updated = "updated"
        case backgroundImage = "background_image"
        case backgroundImageAdditional = "background_image_additional"
        case website = "website"
        case rating = "rating"
        case ratingTop = "rating_top"
        case ratings = "ratings"
        case reactions = "reactions"
        case added = "added"
        case addedByStatus = "added_by_status"
        case playtime = "playtime"
        case screenshotsCount = "screenshots_count"
        case moviesCount = "movies_count"
        case creatorsCount = "creators_count"
        case achievementsCount = "achievements_count"
        case parentAchievementsCount = "parent_achievements_count"
        case redditUrl = "reddit_url"
        case redditName = "reddit_name"
        case redditDescription = "reddit_description"
        case redditLogo = "reddit_logo"
        case redditCount = "reddit_count"
        case twitchCount = "twitch_count"
        case youtubeCount = "youtube_count"
        case reviewsTextCount = "reviews_text_count"
        case ratingsCount = "ratings_count"
        case suggestionsCount = "suggestions_count"
        case alternativeNames = "alternative_names"
        case metacriticUrl = "metacritic_url"
        case parentsCount = "parents_count"
        case additionsCount = "additions_count"
        case gameSeriesCount = "game_series_count"
        case userGame = "user_game"
        case reviewsCount = "reviews_count"
        case saturatedColor = "saturated_color"
        case dominantColor = "dominant_color"
        case parentPlatforms = "parent_platforms"
        case platforms = "platforms"
        case stores = "stores"
        case developers = "developers"
        case genres = "genres"
        case tags = "tags"
        case publishers = "publishers"
        case esrbRating = "esrb_rating"
        case clip = "clip"
        case descriptionRaw = "description_raw"
    }
}

// MARK: - Clip
struct Clip: Codable {
    let clip: String?
    let clips: Clips?
    let video: String?
    let preview: String?

    enum CodingKeys: String, CodingKey {
        case clip = "clip"
        case clips = "clips"
        case video = "video"
        case preview = "preview"
    }
}

// MARK: - Clips
struct Clips: Codable {
    let the320: String?
    let the640: String?
    let full: String?

    enum CodingKeys: String, CodingKey {
        case the320 = "320"
        case the640 = "640"
        case full = "full"
    }
}

// MARK: - Developer
struct Developer: Codable {
    let id: Int?
    let name: String?
    let slug: String?
    let gamesCount: Int?
    let imageBackground: String?
    let domain: String?
    let language: String?

    enum CodingKeys: String, CodingKey {
        case id = "id"
        case name = "name"
        case slug = "slug"
        case gamesCount = "games_count"
        case imageBackground = "image_background"
        case domain = "domain"
        case language = "language"
    }
}

// MARK: - MetacriticPlatform
struct MetacriticPlatform: Codable {
    let metascore: Int?
    let url: String?
    let platform: MetacriticPlatformPlatform?

    enum CodingKeys: String, CodingKey {
        case metascore = "metascore"
        case url = "url"
        case platform = "platform"
    }
}

// MARK: - MetacriticPlatformPlatform
struct MetacriticPlatformPlatform: Codable {
    let platform: Int?
    let name: String?
    let slug: String?

    enum CodingKeys: String, CodingKey {
        case platform = "platform"
        case name = "name"
        case slug = "slug"
    }
}

// MARK: - ParentPlatform
struct ParentPlatform: Codable {
    let platform: EsrbRating?

    enum CodingKeys: String, CodingKey {
        case platform = "platform"
    }
}

// MARK: - PlatformElement
struct PlatformElement: Codable {
    let platform: PlatformPlatform?
    let releasedAt: String?
    let requirements: Requirements?

    enum CodingKeys: String, CodingKey {
        case platform = "platform"
        case releasedAt = "released_at"
        case requirements = "requirements"
    }
}

// MARK: - PlatformPlatform
struct PlatformPlatform: Codable {
    let id: Int?
    let name: String?
    let slug: String?
    let image: String?
    let yearEnd: String?
    let yearStart: YearStart?
    let gamesCount: Int?
    let imageBackground: String?

    enum CodingKeys: String, CodingKey {
        case id = "id"
        case name = "name"
        case slug = "slug"
        case image = "image"
        case yearEnd = "year_end"
        case yearStart = "year_start"
        case gamesCount = "games_count"
        case imageBackground = "image_background"
    }
}

enum YearStart: Codable {
    case integer(Int)
    case string(String)

    init(from decoder: Decoder) throws {
        let container = try decoder.singleValueContainer()
        if let x = try? container.decode(Int.self) {
            self = .integer(x)
            return
        }
        if let x = try? container.decode(String.self) {
            self = .string(x)
            return
        }
        throw DecodingError.typeMismatch(YearStart.self, DecodingError.Context(codingPath: decoder.codingPath, debugDescription: "Wrong type for YearStart"))
    }

    func encode(to encoder: Encoder) throws {
        var container = encoder.singleValueContainer()
        switch self {
        case .integer(let x):
            try container.encode(x)
        case .string(let x):
            try container.encode(x)
        }
    }
}

// MARK: - Requirements
struct Requirements: Codable {
    let minimum: String?
    let recommended: String?

    enum CodingKeys: String, CodingKey {
        case minimum = "minimum"
        case recommended = "recommended"
    }
}

// MARK: - Store
struct StoreDetails: Codable {
    let id: Int?
    let url: String?
    let store: Developer?

    enum CodingKeys: String, CodingKey {
        case id = "id"
        case url = "url"
        case store = "store"
    }
}
