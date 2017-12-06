
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
        // Put setup code here. This method is called before the invocation of each test method in the class.
    }
    
    override func tearDown() {
        // Put teardown code here. This method is called after the invocation of each test method in the class.
        super.tearDown()
    }
    
    func testLoadData() {
        self.subject.loadData()
        XCTAssertTrue(self.mockHomeInteractor.loadDataCalled)

    }
    
    func testHomeControllerInit() {
        XCTAssertNotNil(self.subject.tableView.dataSource)
    }
    
    func testRatingId() {
        let rating = subject.rating(for: 0)
        XCTAssertNotNil(rating)
    }
 
    func testPerformanceExample() {
        // This is an example of a performance test case.
        self.measure {
            // Put the code you want to measure the time of here.
        }
    }
    

    
}
