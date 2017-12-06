
import XCTest
import UIKit
@testable import Ratr

class HomeDataSourceTest: XCTestCase {
    
    var subject: HomeDataSource!
    var mockHomeInteractor: HomeInteractorMock!
    let tableView = UITableView()
    
    override func setUp() {
        super.setUp()
        
        self.mockHomeInteractor = HomeInteractorMock()
        self.subject = HomeDataSource(tableView: tableView, homeInteractor: mockHomeInteractor)

    }
    
    override func tearDown() {
        super.tearDown()
    }
    
    func test_homeInteractorLoadDataIsCalledOnLoadData() {
        self.subject.loadData()
        XCTAssertTrue(self.mockHomeInteractor.loadDataCalled)
    }
    
    func test_homInteractorDeleteRatingIsCalledOnDeleteRating() {
        self.subject.deleteRating(at: 1)
        XCTAssertEqual(self.mockHomeInteractor.deleteRatingCalledWith, 1)
    }
    
    func test_setsTheTablesDataSource() {
        XCTAssertNotNil(self.subject.tableView.dataSource)
    }
    
    func test_getsRatingFromInteractor() {
        let rating = subject.rating(for: 0)
        XCTAssertEqual(rating.id, TestFixtures.rating.id)
    }
}
