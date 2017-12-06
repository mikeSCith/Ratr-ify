import XCTest
import UIKit
@testable import Ratr

class HomeDelegateTest: XCTestCase {
    
    var subject: HomeDelegate!
    var mockRatingClient: RatingClientMock!
    
    override func setUp() {
        super.setUp()
        self.mockRatingClient = RatingClientMock()
//        self.subject = HomeDelegate(nc: UINavigationController(), )
    }
    
    override func tearDown() {
        // Put teardown code here. This method is called after the invocation of each test method in the class.
        super.tearDown()
    }
    
    func testExample() {
        // This is an example of a functional test case.
        // Use XCTAssert and related functions to verify your tests produce the correct results.
    }
    
    func testPerformanceExample() {
        // This is an example of a performance test case.
        self.measure {
            // Put the code you want to measure the time of here.
        }
    }
    
}
