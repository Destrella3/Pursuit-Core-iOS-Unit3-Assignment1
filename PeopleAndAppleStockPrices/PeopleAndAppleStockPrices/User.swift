import Foundation

struct User: Codable {
    let results: [User]
    let name: Name
    let location: Location
    let gender: String
    let email: String
    
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
}

