import Foundation
import UIKit

class ReviewSegmentedControl: UINavigationItem {
    
    @IBOutlet weak var segmentedControl: UISegmentedControl!
    
    func present(one: String, two: String) {
        segmentedControl.setTitle(one, forSegmentAt: 0)
        segmentedControl.setTitle(two, forSegmentAt: 1)
    }
    
}
