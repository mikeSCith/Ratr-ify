import Foundation
import Disk

protocol AddAppInteractorDelegate: NSObjectProtocol {
    func newAppAdded()
}

class AddAppInteractor {
    
    var ratingClient: RatingClientProtocol
    
    var savedRatings: [Rating] = []
    
    var ratings: [Rating] = [] {
        didSet {
            delegate?.newAppAdded()
            try? Disk.save(ratings, to: .caches, as: "ratings.json")
        }
    }
    
    init(_ ratingClient: RatingClientProtocol = RatingClient()) {
        self.ratingClient = ratingClient
    }

    func setRatings(for id: String, on completion: @escaping ((Error?) -> Void)) {
        savedRatings = (try? Disk.retrieve("ratings.json", from: .caches, as: [Rating].self)) ?? []
        if id.isEmpty {
            completion("The ID is empty".error)
            return
        }
        ratingClient.getRating(for: id) { (rating, error)  in
            if let error = error {
                completion(error)
                return
            } else {
                self.ratings = self.savedRatings + [rating!]
                completion(nil)
                return
            }
        }
    }
    
    weak var delegate: AddAppInteractorDelegate?
}



