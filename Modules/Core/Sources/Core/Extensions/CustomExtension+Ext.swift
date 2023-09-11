import Foundation

public enum ServerError: LocalizedError {
    case invalidResponse
    case addressUnreachable(URL)
    
    public var errorDescription: String? {
        switch self {
        case .invalidResponse: return "Invalid response from server, please try again"
        case .addressUnreachable(let url): return "\(url.absoluteString) is unreachable. Please try again later"
        }
    }
}

public enum DatabaseError: LocalizedError {
    case invalidInstance
    case requestFailed
    
    public var errorDescription: String? {
        switch self {
        case.invalidInstance: return "Failed to get Database instance"
        case.requestFailed: return "Request to Database failed"
        }
    }
}
