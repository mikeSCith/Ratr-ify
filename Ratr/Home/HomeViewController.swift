import UIKit

class HomeViewController: UIViewController {
    
    @IBOutlet weak var tableView: UITableView!
    
    var presenter: HomePresenting?
    
    var detailsNavigation: PrimarySplitViewController?
    
    private let cellIndentifier: String = "cell_indentifier"
    
    init() {
        super.init(nibName: String(describing: HomeViewController.self), bundle: nil)
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        navigationController?.navigationItem.title = "Select"
        setupTable()
        setupNav()
    }
    
    override func viewDidAppear(_ animated: Bool) {
        super.viewDidAppear(animated)
        presenter?.updateView()
    }
}

extension HomeViewController: HomeViewControlling {
    
    fileprivate func setupTable() {
        tableView.dataSource = self
        tableView.delegate = self
        tableView.register(UINib(nibName: "HomeCell", bundle: nil), forCellReuseIdentifier: self.cellIndentifier)
        tableView.rowHeight = 234
    }
    
    fileprivate func setupNav() {
        let addNewAppButton = UIBarButtonItem(barButtonSystemItem: .add, target: self, action: #selector(addNewApp))
        navigationItem.rightBarButtonItem = addNewAppButton
    }

    @objc func addNewApp(_ sender: UIBarButtonItem) {
        let vc = AddAppViewController()
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
        if let cell = tableView.dequeueReusableCell(withIdentifier: self.cellIndentifier) as? HomeCell {
            presenter?.buildCell(at: indexPath, using: cell)
            return cell
        } else { return UITableViewCell() }
    }
    
    public func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return presenter?.ratingsCount ?? 0
    }
}

extension HomeViewController: UITableViewDelegate {
    
    public func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        tableView.deselectRow(at: indexPath, animated: true)
        presenter?.cellSelected(at: indexPath)
    }
    
    public func tableView(_ tableView: UITableView, editActionsForRowAt indexPath: IndexPath) -> [UITableViewRowAction]? {
        let action = UITableViewRowAction.init(style: .destructive, title: "REMOVE") { (_, indexPath) in
            self.presenter?.cellSelectedForDelete(at: indexPath)
        }
        return [action]
    }
}
