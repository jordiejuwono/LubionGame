import Foundation
import Common

// MARK: - GameDetailResponse
public struct GameDetailModel {
    public let id: Int?
    public let slug, name, released: String?
    public let backgroundImage, backgroundImageAdditional: String?
    public let website: String?
    public let rating: Double?
    public let ratings: [DetailRatingModel]?
    public let playtime, metacritic: Int?
    public let platforms: [PlatformElementModel]?
    public let developers, genres, publishers: [DeveloperModel]?
    public let clip: String?
    public let descriptionRaw: String?
}

// MARK: - Developer
public struct DeveloperModel {
    public let id: Int?
    public let name, slug: String?
    public let gamesCount: Int?
    public let imageBackground: String?
}

// MARK: - Rating
public struct DetailRatingModel {
    public let id: Int?
    public let title: String?
    public let count: Int?
    public let percent: Double?
}
