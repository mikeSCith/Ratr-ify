import UIKit
import AARatingBar
import Kingfisher

class HomeController: UIViewController {
    
    var dataSource: HomeControllerDataSource!
    var delegate: HomeControllerDelegate!
    
    @IBOutlet weak var tableView: UITableView!
    
    @IBAction func addNewApp(_ sender: UIBarButtonItem) {
        let vc = AddAppController.newController()
        navigationController?.pushViewController(vc, animated: true)
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        dataSource = HomeControllerDataSource(tableView: tableView)
        delegate = HomeControllerDelegate(nc: navigationController!, dataSource: dataSource, tableView: tableView)
    }
    
    override func viewDidAppear(_ animated: Bool) {
        super.viewDidAppear(animated)
        dataSource.loadData()
    }
}


    
