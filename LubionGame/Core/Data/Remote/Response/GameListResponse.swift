//import Foundation
//
//// MARK: - GameListResponse
//struct GameListResponse: Codable {
//    let results: [Result]?
//
//    enum CodingKeys: String, CodingKey {
//        case results
//    }
//}
//
//// MARK: - Result
//struct Result: Codable {
//    let id: Int?
//    let slug, name, released: String?
//    let backgroundImage: String?
//    let rating: Double?
//    let platforms: [PlatformElement]?
//    let genres: [Genre]?
//
//    enum CodingKeys: String, CodingKey {
//        case id, slug, name, released
//        case backgroundImage = "background_image"
//        case rating
//        case platforms
//        case genres
//    }
//}
//
//// MARK: - Genre
//struct Genre: Codable {
//    let id: Int?
//    let name, slug: String?
//    let gamesCount: Int?
//    let imageBackground: String?
//
//    enum CodingKeys: String, CodingKey {
//        case id, name, slug
//        case gamesCount = "games_count"
//        case imageBackground = "image_background"
//    }
//}
//
//// MARK: - PlatformElement
//struct PlatformElement: Codable {
//    let platform: PlatformPlatform?
//    let releasedAt: String?
//
//    enum CodingKeys: String, CodingKey {
//        case platform
//        case releasedAt = "released_at"
//    }
//}
//
//// MARK: - PlatformPlatform
//struct PlatformPlatform: Codable {
//    let id: Int?
//    let name, slug: String?
//    let yearStart: Int?
//    let gamesCount: Int?
//    let imageBackground: String?
//
//    enum CodingKeys: String, CodingKey {
//        case id, name, slug
//        case yearStart = "year_start"
//        case gamesCount = "games_count"
//        case imageBackground = "image_background"
//    }
//}
//
//// MARK: - Rating
//struct Rating: Codable {
//    let id: Int?
//    let title: Title?
//    let count: Int?
//    let percent: Double?
//}
//
//enum Title: String, Codable {
//    case exceptional = "exceptional"
//    case meh = "meh"
//    case recommended = "recommended"
//    case skip = "skip"
//}
