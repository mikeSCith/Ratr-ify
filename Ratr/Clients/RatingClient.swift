
import Alamofire
import SwiftyJSON

protocol RatingClientProtocol {
    func getRating(for id: String, on completion: @escaping ((Rating?, Error?) -> Void))
    func getReview(for id: String, on completion: @escaping (([Review]?, Error?) -> Void))
}

func ratingURL(for id: String) -> String {
    return "http://itunes.apple.com/lookup?id=\(id)"
}

func reviewURL(for id: String) -> String {
    return "http://itunes.apple.com/rss/customerreviews/id=\(id)/json"
}

func mapRating(from json: NSDictionary, for id: String) -> Rating? {
    let serialisedJSON = JSON(json)
    let result = serialisedJSON["results"][0]
    if result.isEmpty {return nil}
    return Rating(
        id: id,
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

func mapReviews(from json: NSDictionary) -> [Review]? {
    let serialisedJSON = JSON(json)
    let results = serialisedJSON["feed"]["entry"]
    if results.isEmpty {return nil}
    let reviews =  results.arrayValue.dropFirst(1)
    return reviews.map({mapReview($0)})
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
    
    func getRating(for id: String, on completion: @escaping (Rating?, Error?) -> Void) {
        
        Alamofire.request(ratingURL(for: id)).responseJSON { (responseJSON) in
            if let json = responseJSON.result.value as? NSDictionary {
                if let rating = mapRating(from: json, for: id) {
                    completion(rating, nil)
                } else {
                    completion(nil, "no results".error)
                }
            } else {
                completion(nil, responseJSON.result.error)
            }
        }
    }
    
    func getReview(for id: String, on completion: @escaping ([Review]?, Error?) -> Void) {
        Alamofire.request(reviewURL(for: id)).responseJSON { (responseJSON) in
            if let json = responseJSON.result.value as? NSDictionary {
                if let review = mapReviews(from: json) {
                    completion(review, nil)
                } else {
                    completion(nil, "no results".error)
                }
                
            } else {
                completion(nil, responseJSON.result.error)
            }
            
        }
    }
}

