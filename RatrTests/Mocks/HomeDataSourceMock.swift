import Foundation
import UIKit
@testable import Ratr

class HomeDataSourceMock: HomeDataSourceProtocol {
    
    var deleteRatingCallCount: UInt = 0
    var deleteRatingCallArgs: Int?
    
    func deleteRating(at index: Int) {
        deleteRatingCallCount += 1
        deleteRatingCallArgs = index
    }
    

    var homeInteractor: HomeInteractorProtocol
    var tableView: UITableView
    var loadDataCalled = false
    
    func loadData() {
        loadDataCalled = true
    }
    
    func rating(for index: Int) -> Rating {
        return TestFixtures.rating
    }
    
    func contentDidChange() {
        return
    }
    
    init(tableView: UITableView, homeInteractor: HomeInteractorProtocol) {
        self.tableView = tableView
        self.homeInteractor = homeInteractor
    }
}
