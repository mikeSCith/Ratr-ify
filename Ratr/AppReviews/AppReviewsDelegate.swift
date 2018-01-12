import Foundation
import UIKit

class AppReviewsDelegate: NSObject, UITableViewDelegate {
    
    var tableView: UITableView
    var reviews: [Review]
    var nc: UINavigationController
    var background: URL
    
    init(tableView: UITableView, reviews: [Review], nc: UINavigationController, background: URL) {
        self.tableView = tableView
        self.reviews = reviews
        self.nc = nc
        self.background = background
        
        super.init()
        
        self.tableView.delegate = self
    }
    
    public func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        let vc = ReviewDetailsController.newController(for: reviews[indexPath.row], with: self.background)
        self.nc.pushViewController(vc, animated: true)
    }
}
