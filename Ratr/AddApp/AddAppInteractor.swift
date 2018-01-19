import Foundation
import Disk

protocol AddAppInteracting {
    var presenter: AddAppPresenting? { get set }
    func saveRatings(with ratings: [Rating])
    func setRatings(for id: String, on completion: @escaping ((Error?) -> Void))
}

class AddAppInteractor: AddAppInteracting {
    
    var presenter: AddAppPresenting?
    
    var ratingClient: RatingClientProtocol
    
    var savedRatings: [Rating] = []
    
    init(presenter: AddAppPresenting, ratingClient: RatingClientProtocol = RatingClient()) {
        self.ratingClient = ratingClient
        self.presenter = presenter
    }
    
    func saveRatings(with ratings: [Rating]) {
        try? Disk.save(ratings, to: .caches, as: "ratings.json")
    }

    func setRatings(for id: String, on completion: @escaping ((Error?) -> Void)) {
        
        if id.isEmpty {
            completion("The ID is empty".error)
            return
        }
        
        savedRatings = (try? Disk.retrieve("ratings.json", from: .caches, as: [Rating].self)) ?? []
        
        ratingClient.getRating(for: id) { (rating, error)  in
            if let error = error {
                completion(error)
                return
            } else {
                self.presenter?.ratings = self.savedRatings + [rating!]
                completion(nil)
                return
            }
        }
    }
}



