import Foundation
import UIKit

protocol HomePresenting {
    
    var ratings: [Rating] { get set }
    
    var ratingsCount: Int { get }
    
    var interactor: HomeViewInteracting? { get set }
    
    var view: HomeViewControlling? { get set }
    
    func updateView()
    
    func buildCell(at indexPath: IndexPath, using cell: HomeCell)
        
    func cellSelected(at indexPath: IndexPath)
    
    func cellSelectedForDelete(at indexPath: IndexPath)
    
    func successfulFetch(for rating: Rating, with reviews: [Review])
    
    func errorFetch()
}

protocol HomeViewControlling {
    
    var presenter: HomePresenting? { get set }
    
    var detailsNavigation: PrimarySplitViewController? { get set }
    
    func reloadData()
    
    func addNewApp(_ sender: UIBarButtonItem)
    
    func pushReviews(for rating: Rating, with Reviews: [Review])
}

protocol HomeViewInteracting {
    
    var presenter: HomePresenting? { get set}
    
    func loadRatingData()

    func fetchReviews(for rating: Rating, with client: RatingClientProtocol)
    
    func deleteRatingData(at indexPath: IndexPath)
}

extension HomeViewInteracting {
    func fetchReviews(for rating: Rating, client: RatingClientProtocol = RatingClient()) {
        return fetchReviews(for: rating, with: client)
    }
}
