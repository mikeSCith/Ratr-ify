import UIKit

class AppDetailsController: UITableViewController {
 
    var rating: Rating!
    var dataSource: AppDetailsDataSource!

    override func viewDidLoad() {
        super.viewDidLoad()
        navigationItem.title = rating.title
        dataSource = AppDetailsDataSource(tableView: tableView, rating: self.rating)
        self.navigationController?.topViewController?.navigationItem.title = rating.title
        setTableHeader()
    }
    
    override func viewDidAppear(_ animated: Bool) {
        super.viewDidAppear(animated)
        self.navigationController?.topViewController?.navigationItem.titleView = nil
    }
    
    override func viewDidLayoutSubviews() {
        super.viewDidLayoutSubviews()
        sizeHeaderToFit()
    }
    
    private func sizeHeaderToFit() {
        if let headerView = tableView.tableHeaderView {
            
            headerView.setNeedsLayout()
            headerView.layoutIfNeeded()
            
            let minHeight = CGFloat(300.00)
            let halfHeight = self.view.window!.frame.size.height / 2
            let height = minHeight > halfHeight ? minHeight : halfHeight
            var newFrame = headerView.frame
            
            if height != newFrame.size.height {
                newFrame.size.height = height
                headerView.frame = newFrame
                tableView.tableHeaderView = headerView
            }
        }
    }

    
    private func setTableHeader() {
        let header = Bundle.main.loadNibNamed("DetailsHeaderCell", owner: nil, options: nil)?.first! as! DetailsHeaderCell
        header.present(rating: rating)
        tableView.tableHeaderView = header
    }
 
    static func newController(for rating: Rating) -> AppDetailsController {
        let storyboard = UIStoryboard(name: "Main", bundle: Bundle.main)
        let vc = storyboard.instantiateViewController(withIdentifier: "AppDetailsController") as! AppDetailsController
        vc.rating = rating
        return vc
    }
}
