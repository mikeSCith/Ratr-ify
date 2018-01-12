import Foundation

class HomePresenter: HomePresenting {
    
    var homeView: HomeViewControlling?
    var interactor: HomeViewInteracting?
    
    var ratings: [Rating] = [] {
        didSet {
            homeView?.reloadData()
        }
    }
    
    var ratingsCount: Int {
        return ratings.count
    }
    
    func updateView() {
        interactor?.loadRatingData()
    }
    
    func cellSelected(at indexPath: IndexPath) {
        let rating = ratings[indexPath.row]
        interactor?.fetchReviews(for: rating)
    }
    
    func cellSelectedForDelete(at indexPath: IndexPath) {
        interactor?.deleteRatingData(at: indexPath)
    }
    
    func successfulFetch(for rating: Rating, with reviews: [Review]) {
        homeView?.pushReviews(for: rating, with: reviews)
    }
    
    func errorFetch() {
        return
    }
}
