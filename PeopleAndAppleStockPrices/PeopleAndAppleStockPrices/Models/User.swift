import Foundation

struct User: Codable {
    let results: [UserInfo]
}
    struct UserInfo: Codable {
        let name: Name
        let location: Location
        let picture: Picture
        let gender: String
        let email: String
}
    struct Name: Codable {
        let title: String
        let first: String
        let last: String
    }
    struct Location: Codable {
        let street: String
        let city: String
        let state: String
        let postcode: String
    }
    struct Picture: Codable {
        let large: URL
    }

