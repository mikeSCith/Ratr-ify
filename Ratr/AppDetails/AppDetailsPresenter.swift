import Foundation
import UIKit

protocol AppDetailsPresenting {
    func generateCell(for rating: Rating, at indexPath: IndexPath) -> DetailsCell
}

class AppDetailsPresenter: AppDetailsPresenting {
    func generateCell(for rating: Rating, at indexPath: IndexPath) -> DetailsCell {
        switch (indexPath.row) {
        case 0:
            return .small(key: "Version", value: rating.latestVersion)
        case 1:
            return .small(key: "Rating", value: String(rating.overallAverageRating))
        case 2:
            return .small(key: "Rating Count", value: String(rating.overallRatingCount))
        case 3:
            return .large(key: "Release Notes", value: rating.releaseNotes)
        default:
            return .small(key: "", value: "")
        }
    }
}
