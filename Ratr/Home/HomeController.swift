import UIKit
import AARatingBar
import Kingfisher

class HomeController: UIViewController, UITableViewDelegate, UITableViewDataSource, HomeInteractorDelegate {
    
    static let cellIndentifier: String = "cell_indentifier"
    
    let homeInteractor = HomeInteractor()
    
    
    @IBAction func addNewApp(_ sender: UIBarButtonItem) {
        let vc = AddAppController.newController()
        navigationController?.pushViewController(vc, animated: true)
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        tableView.register(UINib(nibName: "HomeCell", bundle: nil), forCellReuseIdentifier: HomeController.cellIndentifier)
        tableView.rowHeight = UITableViewAutomaticDimension
        tableView.estimatedRowHeight = 40
        homeInteractor.delegate = self
    }
    
    override func viewDidAppear(_ animated: Bool) {
        super.viewDidAppear(animated)
        homeInteractor.loadData()
    }
    
    // MARK: - Tableview
    
    public func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: HomeController.cellIndentifier)! as! HomeCell
        cell.present(rating: homeInteractor.ratings[indexPath.row])
        return cell
    }

    public func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return homeInteractor.ratings.count
    }
    
    public func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        tableView.deselectRow(at: indexPath, animated: true)
        let vc = AppDetailsController.newController(for: homeInteractor.ratings[indexPath.row])
        navigationController?.pushViewController(vc, animated: true)
    }


    @IBOutlet weak var tableView: UITableView!
    
    func contentDidChange() {
        tableView.reloadData()
    }

}


    
