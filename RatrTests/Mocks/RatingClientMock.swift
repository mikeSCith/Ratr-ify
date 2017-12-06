import Foundation
@testable import Ratr

class RatingClientMock: RatingClientProtocol {
    func getRating(for id: String, on completion: @escaping ((Rating?, Error?) -> Void)) {
        self.getRatingCalledWith = id
        completion(TestFixtures.rating, nil)
    }
    
    func getReview(for id: String, on completion: @escaping (([Review]?, Error?) -> Void)) {
        self.getReviewCalledWith = id
        completion([TestFixtures.review], nil)
    }
    
    var getRatingCalledWith: String?
    var getReviewCalledWith: String?
}
