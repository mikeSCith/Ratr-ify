import XCTest
@testable import Ratr

class AddAppInteractorTest: XCTestCase {
    
    var subject: AddAppInteractor!
    var mockRatingClient: RatingClientMock!
    
    override func setUp() {
        super.setUp()
        self.mockRatingClient = RatingClientMock()
        self.subject = AddAppInteractor(self.mockRatingClient)
    }
    
    override func tearDown() {
        super.tearDown()
    }
    
    func test_ratingClient_isCalledWithAppropriateId() {
        
    }
    
    
}
