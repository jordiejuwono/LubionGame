import Foundation

// MARK: - GameListResponse
public struct GameListModel {
    public let results: [ResultModel]?
}

// MARK: - Result
public struct ResultModel {
    public let id: Int?
    public let name, released: String?
    public let backgroundImage: String?
    public let rating: Double?
    public let platforms: [PlatformElementModel]?
    public let genres: [GenreModel]?
}

// MARK: - Genre
public struct GenreModel {
    public let id: Int?
    public let name, slug: String?
    public let gamesCount: Int?
    public let imageBackground: String?
}

// MARK: - PlatformElement
public struct PlatformElementModel {
    public init(
        platform: PlatformPlatformModel?,
        releasedAt: String?
    ) {
        self.platform = platform
        self.releasedAt = releasedAt
    }
    
    public let platform: PlatformPlatformModel?
    public let releasedAt: String?
}

// MARK: - PlatformPlatform
public struct PlatformPlatformModel {
    public init(
        id: Int?,
        name: String?,
        slug: String?,
        yearStart: Int?,
        gamesCount: Int?,
        imageBackground: String?
    ) {
        self.id = id
        self.name = name
        self.slug = slug
        self.yearStart = yearStart
        self.gamesCount = gamesCount
        self.imageBackground = imageBackground
    }
    public let id: Int?
    public let name, slug: String?
    public let yearStart: Int?
    public let gamesCount: Int?
    public let imageBackground: String?
}

// MARK: - ShortScreenshot
public struct ShortScreenshotModel {
    public let id: Int?
    public let image: String?
}
