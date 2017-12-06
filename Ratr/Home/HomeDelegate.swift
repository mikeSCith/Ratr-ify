

import Foundation
import UIKit

class HomeControllerDelegate: NSObject, UITableViewDelegate {
    
    var nc: UINavigationController
    var ratingClient: RatingClient
    var dataSource: HomeControllerDataSource
    
    init(nc: UINavigationController, dataSource: HomeControllerDataSource, client: RatingClient = RatingClient(), tableView: UITableView){
        self.ratingClient = client
        self.dataSource = dataSource
        self.nc = nc
        super.init()
        tableView.delegate = self
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        tableView.deselectRow(at: indexPath, animated: true)
        
        let rating = dataSource.rating(for: indexPath.row)
        
        ratingClient.getReview(for: rating.id) { (reviews) in
            let vc = RatingTabController.newController(for: rating, reviews: reviews!)
            self.nc.pushViewController(vc, animated: true)
        }
    }
}
