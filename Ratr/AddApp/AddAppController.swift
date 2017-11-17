import Foundation
import UIKit

class AddAppController: UIViewController {
    
    let appInteractor = AddAppInteractor()
    
    @IBOutlet weak var addAppinput: UITextField!
    
    @IBAction func addAppButton(_ sender: Any) {
        guard let text = addAppinput.text else {return}
        appInteractor.setRatings(for: text)
        self.navigationController?.popViewController(animated: true)
    }
    
    static func newController() -> AddAppController {
        let storyboard = UIStoryboard(name: "Main", bundle: Bundle.main)
        return storyboard.instantiateViewController(withIdentifier: "AddAppController") as! AddAppController
    }
    
}
