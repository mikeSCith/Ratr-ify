import Foundation
import Disk

class HomeInteractor: HomeViewInteracting {

    var presenter: HomePresenting?
    var ratingClient: RatingClientProtocol?
    
    var ratings: [Rating] = [] {
        didSet {
            try? Disk.save(ratings, to: .caches, as: "ratings.json")
            presenter?.ratings = ratings
        }
    }
    
    func loadRatingData() {
        let savedRatings = try? Disk.retrieve("ratings.json", from: .caches, as: [Rating].self)
        self.ratings = savedRatings ?? []
    }
    
    func deleteRatingData(at indexPath: IndexPath) {
        var newRatings = ratings
        newRatings.remove(at: indexPath.row)
        ratings = newRatings
    }
    
    func fetchReviews(
        for rating: Rating,
        with client: RatingClientProtocol = RatingClient()) {
        
        client.getReview(for: rating.id) { (reviews, error) in
            if let reviews = reviews {
                self.presenter?.successfulFetch(for: rating, with: reviews)
            } else {
                self.presenter?.errorFetch()
            }
        }
    }
}
