import UIKit

class AppDetailsViewController: UIViewController {
 
    @IBOutlet weak var tableView: UITableView!
    
    var presenter: AppDetailsPresenting?
    var rating: Rating
    
    init(for rating: Rating) {
        self.rating = rating
        super.init(nibName: "AppDetailsViewController", bundle: nil)
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    override func viewDidLoad() {
        tableView.dataSource = self
        self.navigationController?.topViewController?.navigationItem.title = rating.title
        setTableHeader()
    }
    
    override func viewDidAppear(_ animated: Bool) {
        super.viewDidAppear(animated)
        self.navigationController?.topViewController?.navigationItem.titleView = nil
        navigationItem.title = rating.title
    }
    
    override func viewDidLayoutSubviews() {
        super.viewDidLayoutSubviews()
        sizeHeaderToFit()
    }
    
}

private extension AppDetailsViewController {
    func sizeHeaderToFit() {
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
    
    func setTableHeader() {
        let header = Bundle.main.loadNibNamed("DetailsHeaderCell", owner: nil, options: nil)?.first! as! DetailsHeaderCell
        header.present(rating: rating)
        tableView.tableHeaderView = header
    }
}

extension AppDetailsViewController: UITableViewDataSource {
    
    public func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        return presenter!.generateCell(for: rating, at: indexPath).cell
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int { return 4 }
}
