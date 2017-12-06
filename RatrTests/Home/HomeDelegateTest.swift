import XCTest
import UIKit
@testable import Ratr

class HomeDelegateTest: XCTestCase {
    
    var subject: HomeDelegate!
    var mockRatingClient: RatingClientMock!
    var mockDataSource: HomeDataSourceMock!
    var mockHomeInteractor: HomeInteractorMock!
    var tableView = UITableView()
    var nc: MockNavigationController!
    
    override func setUp() {
        super.setUp()
        self.mockRatingClient = RatingClientMock()
        self.mockHomeInteractor = HomeInteractorMock()
        self.nc = MockNavigationController()
        self.mockDataSource = HomeDataSourceMock(tableView: tableView, homeInteractor: mockHomeInteractor)
        self.subject = HomeDelegate(nc: nc, dataSource: mockDataSource, client: mockRatingClient, tableView: tableView)
    }
    
    override func tearDown() {
        super.tearDown()
    }
    
    func test_ratingClient_isCalledWithAppropriateId() {
        subject.tableView(tableView, didSelectRowAt: IndexPath.init(row: 0, section: 0))
        XCTAssertEqual(mockRatingClient.getReviewCalledWith, TestFixtures.rating.id)
    }
    
    func test_tableViewEditActionsForRowAt_returnsTheCorrectActions() {
        let actions = subject.tableView(tableView, editActionsForRowAt: IndexPath.init(row: 0, section: 0))
        XCTAssertEqual(actions?.count, 1)
    }
    
    func test_ratingClient_pushesNewViewController() {
        subject.tableView(tableView, didSelectRowAt: IndexPath.init(row: 0, section: 0))
        XCTAssertEqual(nc.pushViewControllerCount, 1)
    }
    
    func test_ratingClient_pushesCorrectViewController() {
        subject.tableView(tableView, didSelectRowAt: IndexPath.init(row: 0, section: 0))
        XCTAssertTrue(nc.pushedViewController!.isKind(of: RatingTabController.self))
    }
}
