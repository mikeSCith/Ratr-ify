import Disk

protocol AddAppInteracting: class {
    var presenter: AddAppPresenting? { get set }
    func saveRatings(with ratings: [Rating])
    func setRatings(for id: String, on completion: @escaping ((Error?) -> Void))
}

class AddAppInteractor: AddAppInteracting {
    
    weak var presenter: AddAppPresenting?
    private var ratingClient: RatingClientProtocol
    private var savedRatings: [Rating] = []
    private var ratingFile: String
    
    init(ratingClient: RatingClientProtocol = RatingClient(),
        ratingFile: String = "ratings.json") {
        self.ratingClient = ratingClient
        self.ratingFile = ratingFile
    }
    
    func saveRatings(with ratings: [Rating]) {
        try? Disk.save(ratings, to: .caches, as: ratingFile)
    }

    func setRatings(for id: String, on completion: @escaping ((Error?) -> Void)) {
        
        if id.isEmpty {
            completion("The ID is empty".error)
            return
        }
        
        savedRatings = (try? Disk.retrieve(ratingFile, from: .caches, as: [Rating].self)) ?? []
        
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



