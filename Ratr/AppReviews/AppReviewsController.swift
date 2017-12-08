import Foundation
import UIKit

class AppReviewsController: UIViewController {
    
    static let reviewCellIdentifier: String = "review_identifier"
    @IBOutlet weak var tableView: UITableView!
    
    var positiveReviews: [Review]!
    var negativeReviews: [Review]!
    var reviews: [Review]!
    var dataSource: AppReviewsDataSource!
    var delegate: AppReviewsDelegate!
    var sc: UISegmentedControl!
    
    var showPositive = true
    
    override func viewDidLoad() {
        super.viewDidLoad()
            
        dataSource = AppReviewsDataSource(tableView: tableView, reviews: reviews)
        delegate = AppReviewsDelegate(tableView: tableView, reviews: reviews, nc: self.navigationController!)
        
        let items = ["Positive", "Negative"]
        sc = UISegmentedControl(items: items)
        sc.tintColor = UIColor(red:1.00, green:0.47, blue:0.00, alpha:1.0)
        sc.selectedSegmentIndex = 0
        sc.addTarget(self, action: #selector(segmentSelected), for: UIControlEvents.valueChanged)
    }
    
    
    override func viewDidAppear(_ animated: Bool) {
        
        self.navigationController?.topViewController?.navigationItem.titleView = sc
    }
    
    @objc func segmentSelected(sender: UISegmentedControl) {
        if showPositive {
            showPositive = false
            dataSource.reloadData(with: self.negativeReviews)
            delegate.reviews = negativeReviews
        } else {
            showPositive = true
            dataSource.reloadData(with: self.positiveReviews)
            delegate.reviews = positiveReviews
        }
        
    }
    
    static func newController(for reviews: [Review]) -> AppReviewsController {
        let storyboard = UIStoryboard(name: "Main", bundle: Bundle.main)
        let vc = storyboard.instantiateViewController(withIdentifier: "AppReviewsController") as! AppReviewsController
        let positiveReviews = reviews.filter { !(Double($0.rating)?.isLess(than: 2.5))! }
        let negativeReviews = reviews.filter { (Double($0.rating)?.isLess(than: 2.5))! }
        vc.positiveReviews = positiveReviews
        vc.negativeReviews = negativeReviews
        vc.reviews = vc.positiveReviews
        return vc
    }
}
