

import Foundation
import UIKit

class HomeDelegate: NSObject, UITableViewDelegate {
    
    var ratingClient: RatingClientProtocol
    var dataSource: HomeDataSourceProtocol
    var sc: UISplitViewController
        
    init(dataSource: HomeDataSourceProtocol, client: RatingClientProtocol = RatingClient(), tableView: UITableView, sc: UISplitViewController){
        
        self.ratingClient = client
        self.dataSource = dataSource
        self.sc = sc
        super.init()
        
        tableView.delegate = self
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        tableView.deselectRow(at: indexPath, animated: true)
        
        let rating = dataSource.rating(for: indexPath.row)
        
        ratingClient.getReview(for: rating.id) { (reviews, error) in
            let vc = RatingTabController.newController(for: rating, reviews: reviews!)
            if self.sc.viewControllers.count > 1 {
                let x = self.sc.viewControllers[1] as! UINavigationController
                x.pushViewController(vc, animated: true)
            } else {
                let x = self.sc.viewControllers[0] as! UINavigationController
                x.pushViewController(vc, animated: true)
            }
        }
    }
    
    func tableView(_ tableView: UITableView, editActionsForRowAt indexPath: IndexPath) -> [UITableViewRowAction]? {
        let action = UITableViewRowAction.init(style: .destructive, title: "REMOVE") { (_, indexPath) in
            self.dataSource.deleteRating(at: indexPath.row)
        }
        return [action]
    }
}


