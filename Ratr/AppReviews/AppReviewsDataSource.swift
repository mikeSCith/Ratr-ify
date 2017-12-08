import Foundation
import UIKit

class AppReviewsDataSource: NSObject, UITableViewDataSource {
    
    var reviews: [Review]
    var tableView: UITableView
    
    init(tableView: UITableView, reviews: [Review]) {
        
        self.reviews = reviews
        self.tableView = tableView
        self.tableView.register(UINib(nibName: "ReviewCell", bundle: nil), forCellReuseIdentifier: AppReviewsController.reviewCellIdentifier)

        super.init()
        
        self.tableView.dataSource = self
    }
    
    public func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return reviews.count
    }
    
    public func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: AppReviewsController.reviewCellIdentifier)! as! ReviewCell
        cell.present(review: reviews[indexPath.row])
        return cell
    }
    
    public func reloadData(with reviews: [Review]) {
        self.reviews = reviews
        tableView.reloadData()
    }
}
