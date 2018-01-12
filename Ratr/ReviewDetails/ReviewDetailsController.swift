import Foundation
import UIKit
import Kingfisher


class ReviewDetailsController: UITableViewController {
    
    var review: Review!
    var background: URL!
    var dataSource: ReviewDetailsDataSource!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        dataSource = ReviewDetailsDataSource(review: review, tableView: tableView)
        setHeader()
    }
    
    override func viewDidAppear(_ animated: Bool) {
        super.viewDidAppear(animated)
    }
    
    private func setHeader() {
        let header = Bundle.main.loadNibNamed("ReviewDetailsHeaderCell", owner: nil, options: nil)?.first! as! ReviewDetailsHeaderCell
        header.present(for: review.rating, with: review.title, with: review.comment)
        tableView.tableHeaderView = header
        setBackground()
    }
    
    private func setBackground() {
        var imageView: UIImageView!
        imageView = UIImageView(frame: view.bounds)
        imageView.contentMode =  UIViewContentMode.scaleToFill
        imageView.clipsToBounds = true
        imageView.kf.setImage(with: background)
        imageView.center = tableView.tableHeaderView!.center
        tableView.tableHeaderView!.addSubview(imageView)
        self.tableView.tableHeaderView?.sendSubview(toBack: imageView)
    }
 
    override func viewDidLayoutSubviews() {
        super.viewDidLayoutSubviews()
        sizeHeaderToFit()
    }
    
    private func sizeHeaderToFit() {
        if let headerView = tableView.tableHeaderView {

            let minHeight = CGFloat(350.00)
            let halfHeight = self.view.window!.frame.size.height * 3 / 4
            let height = minHeight > halfHeight ? minHeight : halfHeight
            var newFrame = headerView.frame

            if height != newFrame.size.height {
                newFrame.size.height = height
                headerView.frame = newFrame
                tableView.tableHeaderView = headerView
            }

            headerView.setNeedsLayout()
            headerView.layoutIfNeeded()
        }
    }
    
    static func newController(for review: Review, with background: URL) -> ReviewDetailsController {
        let storyboard = UIStoryboard(name: "Main", bundle: Bundle.main)
        let vc = storyboard.instantiateViewController(withIdentifier: "ReviewDetailsController") as! ReviewDetailsController
        vc.review = review
        vc.background = background
        return vc
    }
}
