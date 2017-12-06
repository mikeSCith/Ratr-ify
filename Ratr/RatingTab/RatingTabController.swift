import Foundation
import UIKit

class RatingTabController: UITabBarController {
    
    var rating: Rating!
    
    override func viewDidLoad() {
        let ratingImage =  UIImage(named: "rating.png")
        let appDetailsController = AppDetailsController.newController(for: rating)
        appDetailsController.tabBarItem = UITabBarItem(title: "Rating", image: ratingImage, tag: 0)
        let app
        let viewControllerList = [appDetailsController]
        viewControllers = viewControllerList
    }
    
    static func newController(for rating: Rating) -> RatingTabController {
        let storyboard = UIStoryboard(name: "Main", bundle: Bundle.main)
        let vc = storyboard.instantiateViewController(withIdentifier: "RatingTabController") as! RatingTabController
        vc.rating = rating
        return vc
    }

}

