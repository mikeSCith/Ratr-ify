import UIKit
import AARatingBar
import Kingfisher

class HomeViewController: UIViewController {
    
    var dataSource: HomeDataSource!
    var delegate: HomeDelegate!
    
    var detailsNavigation: UISplitViewController!
    
    @IBOutlet weak var tableView: UITableView!
    
    @IBAction func addNewApp(_ sender: UIBarButtonItem) {
        let vc = AddAppViewController.newController()
        navigationController?.pushViewController(vc, animated: true)
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.navigationController?.navigationItem.title = "Select"
        dataSource = HomeDataSource(tableView: tableView)
        delegate = HomeDelegate(dataSource: dataSource, tableView: tableView, sc: detailsNavigation)
    }
    
    override func viewDidAppear(_ animated: Bool) {
        super.viewDidAppear(animated)
        dataSource.loadData()
    }
}
