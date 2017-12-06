import Foundation
import UIKit


class HomeControllerDataSource: NSObject, UITableViewDataSource, HomeInteractorDelegate, HomeControllerDataSourceProtocol {

    let cellIndentifier: String = "cell_indentifier"
    
    var homeInteractor: HomeInteractorProtocol
    var tableView: UITableView
    
    init(tableView: UITableView, homeInteractor: HomeInteractorProtocol) {
        
        self.homeInteractor = homeInteractor
        self.tableView = tableView
        
        super.init()
        
        self.homeInteractor.delegate = self
        self.tableView.dataSource = self
        
        self.tableView.register(UINib(nibName: "HomeCell", bundle: nil), forCellReuseIdentifier: self.cellIndentifier)
        self.tableView.rowHeight = UITableViewAutomaticDimension
        self.tableView.estimatedRowHeight = 40
    }
    
    convenience init(tableView: UITableView){
        self.init(tableView: tableView, homeInteractor: HomeInteractor())
    }
    
    public func loadData() {
        homeInteractor.loadRatingData()
    }
    
    public func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: self.cellIndentifier)! as! HomeCell
        cell.present(rating: homeInteractor.ratings[indexPath.row])
        return cell
    }
    
    public func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return homeInteractor.ratings.count
    }
    
    public func rating(for index: Int) -> Rating {
        return homeInteractor.ratings[index]
    }
    
    func contentDidChange() {
        tableView.reloadData()
    }
}
