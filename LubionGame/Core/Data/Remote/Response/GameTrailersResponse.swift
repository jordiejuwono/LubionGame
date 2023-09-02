import Foundation

// MARK: - GameTrailersResponse
struct GameTrailersResponse: Codable {
    let results: [TrailerResult]?
}

// MARK: - Result
struct TrailerResult: Codable {
    let id: Int?
    let name: String?
    let preview: String?
    let data: DataClass?
}

// MARK: - DataClass
struct DataClass: Codable {
    let the480, max: String?

    enum CodingKeys: String, CodingKey {
        case the480 = "480"
        case max
    }
}
