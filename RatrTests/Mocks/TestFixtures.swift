import Foundation
@testable import Ratr

class TestFixtures {
    static let rating = Rating(id: "test-id", title: "test-title", appIconSmall: URL(string: "test-small-icon")!, appIconLarge: URL(string: "test-large-icon")!, latestVersion: "1", averageRatingForVersion: 1.0, averageRatingCountForVersion: 1, releaseNotes: "test-notes", overallAverageRating: 2.0, overallRatingCount: 2)
    
    static let review = Review.init(authorName: "test-name", title: "test-title", comment: "test-comment", rating: "test-rating", appVersion: "test-version")
}
