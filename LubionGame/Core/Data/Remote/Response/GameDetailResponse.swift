import Foundation

// MARK: - GameDetailResponse
struct GameDetailResponse: Codable {
    let id: Int?
    let slug, name, released: String?
    let backgroundImage, backgroundImageAdditional: String?
    let website: String?
    let rating: Double?
    let ratings: [DetailRating]?
    let playtime, metacritic: Int?
    let platforms: [PlatformElement]?
    let developers, genres, publishers: [Developer]?
    let clip: String?
    let descriptionRaw: String?

    enum CodingKeys: String, CodingKey {
        case id, slug, name, released
        case backgroundImage = "background_image"
        case backgroundImageAdditional = "background_image_additional"
        case website, rating, metacritic, platforms, ratings, playtime, developers, genres, publishers, clip
        case descriptionRaw = "description_raw"
    }
}

// MARK: - Developer
struct Developer: Codable {
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

// MARK: - Rating
struct DetailRating: Codable {
    let id: Int?
    let title: String?
    let count: Int?
    let percent: Double?
}
