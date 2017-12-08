import Foundation
import Disk

protocol HomeInteractorDelegate: NSObjectProtocol {
    func contentDidChange()
}

class HomeInteractor: HomeInteractorProtocol {
    
    var ratings: [Rating] = [] {
        didSet {
            delegate?.contentDidChange()
            try? Disk.save(ratings, to: .caches, as: "ratings.json")
        }
    }
    
    func loadRatingData() {
        let savedRatings = try? Disk.retrieve("ratings.json", from: .caches, as: [Rating].self)
        self.ratings = savedRatings ?? []
    }
    
    func deleteRatingData(at index: Int) {
        var newRatings = ratings
        newRatings.remove(at: index)
        ratings = newRatings
    }
    
    weak var delegate: HomeInteractorDelegate?
}
