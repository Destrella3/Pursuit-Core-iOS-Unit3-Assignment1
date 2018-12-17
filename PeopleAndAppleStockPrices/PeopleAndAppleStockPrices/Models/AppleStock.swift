import Foundation

struct StockResults: Codable {
    let result: [AppleStock]
}
struct AppleStock: Codable {
    let date: String
    let open: Double
    let high: Double
    let low: Double
    let close: Double
    let volume: Int
    let unadjustedVolume: Int
    let change: Double
    let changePercent: Double
    let vwap: Double
    let label: String
    let changeOverTime: Double
}
