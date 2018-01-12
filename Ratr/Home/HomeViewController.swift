import UIKit
import Kingfisher

class HomeViewController: UIViewController {
    
    @IBOutlet weak var tableView: UITableView!
    
    var presenter: HomePresenting?
    
    var detailsNavigation: UISplitViewController?
    
    let cellIndentifier: String = "cell_indentifier"
    
    override func viewDidLoad() {
        super.viewDidLoad()
        navigationController?.navigationItem.title = "Select"
        tableView.dataSource = self
        tableView.delegate = self
        tableView.register(UINib(nibName: "HomeCell", bundle: nil), forCellReuseIdentifier: self.cellIndentifier)
        tableView.rowHeight = 234
        presenter?.updateView()
    }
    
    override func viewDidAppear(_ animated: Bool) {
        super.viewDidAppear(animated)
    }
}

extension HomeViewController: HomeViewControlling {

    func addNewApp(_ sender: UIBarButtonItem) {
        let vc = AddAppViewController.newController()
        navigationController?.pushViewController(vc, animated: true)
    }
    
    func reloadData() {
        tableView.reloadData()
    }
    
    func pushReviews(for rating: Rating, with reviews: [Review]) {
        let viewController = RatingTabController.newController(for: rating, reviews: reviews)
        
        if self.splitViewController!.viewControllers.count > 1 {
            let x = self.splitViewController?.viewControllers[1] as! UINavigationController
            x.pushViewController(viewController, animated: true)
        } else {
            let x = self.splitViewController?.viewControllers[0] as! UINavigationController
            x.pushViewController(viewController, animated: true)
        }
        
    }
}

extension HomeViewController: UITableViewDataSource {
    
    public func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: self.cellIndentifier)! as! HomeCell
        guard let rating = presenter?.ratings[indexPath.row] else { return UITableViewCell() }
        cell.present(rating: rating)
        return cell
    }
    
    public func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return presenter?.ratingsCount ?? 0
    }
}

extension HomeViewController: UITableViewDelegate {
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        tableView.deselectRow(at: indexPath, animated: true)
        presenter?.cellSelected(at: indexPath)
    }
    
    func tableView(_ tableView: UITableView, editActionsForRowAt indexPath: IndexPath) -> [UITableViewRowAction]? {
        let action = UITableViewRowAction.init(style: .destructive, title: "REMOVE") { (_, indexPath) in
            self.presenter?.cellSelectedForDelete(at: indexPath)
        }
        return [action]
    }
}
