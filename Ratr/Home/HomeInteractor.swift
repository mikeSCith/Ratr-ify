import Disk

class HomeInteractor: HomeViewInteracting {

    weak var presenter: HomePresenting?
    
    func loadRatingData() {
        let savedRatings = try? Disk.retrieve("ratings.json", from: .caches, as: [Rating].self)
        presenter?.ratings = savedRatings ?? []
    }
    
    func deleteRatingData(at indexPath: IndexPath) {
        let filteredRatings = presenter?.ratings
            .enumerated()
            .filter { $0.offset != indexPath.row }
            .map { $0.element }
        
        try? Disk.save(filteredRatings, to: .caches, as: "ratings.json")
        loadRatingData()
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
