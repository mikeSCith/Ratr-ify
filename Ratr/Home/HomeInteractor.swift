import Foundation
import Disk

protocol HomeInteractorDelegate: NSObjectProtocol {
    func contentDidChange()
}

class HomeInteractor {
        
    func loadData() {
        let savedRatings = try? Disk.retrieve("ratings.json", from: .caches, as: [Rating].self)
        self.ratings = savedRatings ?? []
    }
    
    var ratings: [Rating] = [] {
        didSet {
            delegate?.contentDidChange()
            try? Disk.save(ratings, to: .caches, as: "ratings.json")
        }
    }
    
    weak var delegate: HomeInteractorDelegate?
}
