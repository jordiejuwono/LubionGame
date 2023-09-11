import Foundation

// MARK: - GameListResponse
public struct GameListResponse: Codable {
    let results: [Result]?

    enum CodingKeys: String, CodingKey {
        case results
    }
}

// MARK: - Result
public struct Result: Codable {
    let id: Int?
    let slug, name, released: String?
    let backgroundImage: String?
    let rating: Double?
    let platforms: [PlatformElement]?
    let genres: [Genre]?

    enum CodingKeys: String, CodingKey {
        case id, slug, name, released
        case backgroundImage = "background_image"
        case rating
        case platforms
        case genres
    }
}

// MARK: - Genre
public struct Genre: Codable {
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

// MARK: - PlatformElement
public struct PlatformElement: Codable {
    public let platform: PlatformPlatform?
    public let releasedAt: String?

    enum CodingKeys: String, CodingKey {
        case platform
        case releasedAt = "released_at"
    }
}

// MARK: - PlatformPlatform
public struct PlatformPlatform: Codable {
    public let id: Int?
    public let name, slug: String?
    public let yearStart: Int?
    public let gamesCount: Int?
    public let imageBackground: String?

    enum CodingKeys: String, CodingKey {
        case id, name, slug
        case yearStart = "year_start"
        case gamesCount = "games_count"
        case imageBackground = "image_background"
    }
}

// MARK: - Rating
public struct Rating: Codable {
    public let id: Int?
    public let title: Title?
    public let count: Int?
    public let percent: Double?
}

public enum Title: String, Codable {
    case exceptional = "exceptional"
    case meh = "meh"
    case recommended = "recommended"
    case skip = "skip"
}
