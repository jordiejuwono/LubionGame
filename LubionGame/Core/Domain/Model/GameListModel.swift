import Foundation

// MARK: - GameListResponse
struct GameListModel {
    let results: [ResultModel]?
}

// MARK: - Result
struct ResultModel {
    let id: Int?
    let name, released: String?
    let backgroundImage: String?
    let rating: Double?
    let platforms: [PlatformElementModel]?
    let genres: [GenreModel]?
}

// MARK: - Genre
struct GenreModel {
    let id: Int?
    let name, slug: String?
    let gamesCount: Int?
    let imageBackground: String?
}

// MARK: - PlatformElement
struct PlatformElementModel {
    let platform: PlatformPlatformModel?
    let releasedAt: String?
}

// MARK: - PlatformPlatform
struct PlatformPlatformModel {
    let id: Int?
    let name, slug: String?
    let yearStart: Int?
    let gamesCount: Int?
    let imageBackground: String?
}

// MARK: - ShortScreenshot
struct ShortScreenshotModel {
    let id: Int?
    let image: String?
}
