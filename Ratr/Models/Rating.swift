import Foundation

struct Rating: Codable {
    let id: String
    let title: String;
    let appIconSmall: URL;
    let appIconLarge: URL;
    let latestVersion: String;
    let averageRatingForVersion: Float;
    let averageRatingCountForVersion: Int;
    let releaseNotes: String;
    let overallAverageRating: Float;
    let overallRatingCount: Int;
}
