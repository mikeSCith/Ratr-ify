import Foundation
import UIKit

class ReviewDetailsDataSource: NSObject, UITableViewDataSource {
    
    var review: Review
    var tableView: UITableView
    
    init(review: Review, tableView: UITableView) {
        self.tableView = tableView
        self.review = review
        super.init()
        self.tableView.dataSource = self
    }

    public func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {return 3}
    
    public func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        
        let cell = Bundle.main.loadNibNamed("ReviewDetailsCell", owner: nil, options: nil)?.first! as! ReviewDetailsCell
        
        switch(indexPath.row) {
        case 0:
            cell.present(key: "Name", value: review.authorName)
            return cell
        case 1:
            cell.present(key: "Rating", value: review.rating)
            return cell
        case 2:
            cell.present(key: "Version", value: review.appVersion)
            return cell
        default:
            return UITableViewCell()
        }
        
    }

}
