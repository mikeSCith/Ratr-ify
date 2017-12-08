import Foundation
import UIKit

class AppReviewsDelegate: NSObject, UITableViewDelegate {
    
    var tableView: UITableView
    var reviews: [Review]
    var nc: UINavigationController
    
    init(tableView: UITableView, reviews: [Review], nc: UINavigationController) {
        self.tableView = tableView
        self.reviews = reviews
        self.nc = nc
        
        super.init()
        
        self.tableView.delegate = self
    }
    
    public func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        let vc = ReviewDetailsController.newController(for: reviews[indexPath.row])
        self.nc.pushViewController(vc, animated: true)
    }
}
