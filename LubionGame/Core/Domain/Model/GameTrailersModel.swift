import Foundation

// MARK: - GameTrailersResponse
struct GameTrailersModel: Codable {
    let results: [TrailerResultModel]?
}

// MARK: - Result
struct TrailerResultModel: Codable {
    let id: Int?
    let name: String?
    let preview: String?
    let data: DataClassModel?
}

// MARK: - DataClass
struct DataClassModel: Codable {
    let the480, max: String?
}
