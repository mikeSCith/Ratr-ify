import Foundation
import UIKit

class RatingTabController: UITabBarController {
    
    var rating: Rating!
    var reviews: [Review]!
    var appReviewsController: UIViewController!
    
    override func viewDidLoad() {
        
        let ratingImage =  UIImage(named: "rating.png")
        let reviewImage = UIImage(named: "review.png")
        
        let appDetailsController = AppDetails.build(for: rating)
        appDetailsController.tabBarItem = UITabBarItem(title: "Rating", image: ratingImage, tag: 0)
        
        appReviewsController = AppReviewsController.newController(for: reviews, with: rating.appIconLarge)
        appReviewsController.tabBarItem = UITabBarItem(title: "Reviews", image: reviewImage, tag: 1)
        
        let viewControllerList = [appDetailsController, appReviewsController]
        viewControllers = viewControllerList as? [UIViewController]
        
    }
    
    static func newController(for rating: Rating, reviews: [Review]) -> RatingTabController {
        let storyboard = UIStoryboard(name: "Main", bundle: Bundle.main)
        let vc = storyboard.instantiateViewController(withIdentifier: "RatingTabController") as! RatingTabController
        vc.rating = rating
        vc.reviews = reviews
        return vc
    }

}

