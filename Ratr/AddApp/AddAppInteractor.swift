import Foundation
import Disk

class AddAppInteractor {
    
    let ratingClient = RatingClient()

    func setRatings(for id: String) {
        let savedRatings: [Rating]
        do {
            savedRatings = try Disk.retrieve("ratings.json", from: .caches, as: [Rating].self)
        } catch {
            print(error)
            return
        }
        
        ratingClient.getRating(for: id) { (rating) in
            guard let rating = rating else {return}
            do {
                try Disk.save(savedRatings + [rating], to: .caches, as: "ratings.json")
            } catch {
                print(error)
            }
        }
    }
    
    
}
