import Foundation

class HomePresenter: HomePresenting {

    var view: HomeViewControlling?
    var interactor: HomeViewInteracting?
    
    var ratings: [Rating] = [] {
        didSet {
            view?.reloadData()
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
        view?.pushReviews(for: rating, with: reviews)
    }
    
    func errorFetch() {
        return
    }
    
    func buildCell(at indexPath: IndexPath, using cell: HomeCell) {
        cell.present(rating: ratings[indexPath.row])
    }
}
