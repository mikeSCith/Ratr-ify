
import Alamofire
import SwiftyJSON

protocol RatingClientProtocol {
    func getRating(for id: String, on completion: @escaping ((Rating?) -> Void))
    func getReview(for id: String, on completion: @escaping (([Review]?) -> Void))
}

func ratingURL(for id: String) -> String {
    return "http://itunes.apple.com/lookup?id=\(id)"
}

func reviewURL(for id: String) -> String {
    return "http://itunes.apple.com/rss/customerreviews/id=\(id)/json"
}

func mapRating(from json: NSDictionary) -> Rating {
    let serialisedJSON = JSON(json)
    let result = serialisedJSON["results"][0]
    return Rating(
        title: result["trackName"].stringValue,
        appIconSmall: URL(string: String(describing: result["artworkUrl100"]))!,
        appIconLarge: URL(string: String(describing: result["artworkUrl512"]))!,
        latestVersion: result["version"].stringValue,
        averageRatingForVersion: result["averageUserRatingForCurrentVersion"].floatValue,
        averageRatingCountForVersion: result["userRatingCountForCurrentVersion"].intValue,
        releaseNotes: result["releaseNotes"].stringValue,
        overallAverageRating: result["averageUserRating"].floatValue,
        overallRatingCount: result["userRatingCount"].intValue
    )
}

func mapReviews(from json: NSDictionary) -> [Review] {
    let serialisedJSON = JSON(json)
    let results = serialisedJSON["feed"]["entry"].arrayValue.dropFirst(1)
    
    return results.map({mapReview($0)})
}

func mapReview(_ review: JSON) -> Review {
    return Review(
        authorName: review["author"]["name"]["label"].stringValue,
        title: review["title"]["label"].stringValue,
        comment: review["content"]["label"].stringValue,
        rating: review["im:rating"]["label"].stringValue,
        appVersion: review["im:version"]["label"].stringValue
    )
}

class RatingClient: RatingClientProtocol {
    
    
    func getRating(for id: String, on completion: @escaping (Rating?) -> Void) {
        
        Alamofire.request(ratingURL(for: id)).responseJSON { (responseJSON) in
            if let json = responseJSON.result.value as? NSDictionary {
                let rating = mapRating(from: json)
                completion(rating)
            } else {
                completion(nil)
            }
        }
        
    }
    
    func getReview(for id: String, on completion: @escaping ([Review]?) -> Void) {
        Alamofire.request(reviewURL(for: id)).responseJSON { (responseJSON) in
            if let json = responseJSON.result.value as? NSDictionary {
                let review = mapReviews(from: json)
                completion(review)
            } else {
                completion(nil)
            }
            
        }
    }
}

