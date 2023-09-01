import Foundation

enum ServerError: LocalizedError {
    case invalidResponse
    case addressUnreachable(URL)
    
    var errorDescription: String? {
        switch self {
        case .invalidResponse: return "Invalid response from server, please try again"
        case .addressUnreachable(let url): return "\(url.absoluteString) is unreachable. Please try again later"
        }
    }
}
