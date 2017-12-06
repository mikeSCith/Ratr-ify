import Foundation
@testable import Ratr

class HomeInteractorMock: HomeInteractorProtocol {
    func deleteRatingData(at index: Int) {
        deleteRatingCalledWith = 1
    }
    
    func loadRatingData() {
        loadDataCalled = true
    }
    
    
    var ratings: [Rating]
    
    var delegate: HomeInteractorDelegate?
    
    var loadDataCalled = false
    var deleteRatingCalledWith = 0
    
    init() {
        let rating = TestFixtures.rating
        
        ratings = [Rating]()
        ratings.append(rating)
    }
}
