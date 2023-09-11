import Foundation

public struct GameTableModel {
    public init(
        id: Int?,
        name: String?,
        backgroundImage: String?
    ) {
        self.id = id
        self.name = name
        self.backgroundImage = backgroundImage
    }
    public let id: Int?
    public let name: String?
    public let backgroundImage: String?
}
