import Foundation
import UIKit

class MockNavigationController: UINavigationController {
    
    var pushViewControllerCount: UInt = 0
    var pushedViewController: UIViewController?
    
    override func pushViewController(_ viewController: UIViewController, animated: Bool) {
        pushViewControllerCount += 1
        pushedViewController = viewController
    }
}
