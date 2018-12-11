import Foundation

enum UserAPIError: Error {
    case badURL(String)
    case networkError(Error)
    case decodingError(Error)
}

final class UserAPI {
    static func userSearch() {
        
    }
}
