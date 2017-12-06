import Foundation
import UIKit

class AddAppViewController: UIViewController, AddAppInteractorDelegate {
    
    var addAppInteractor = AddAppInteractor()
    
    @IBOutlet weak var addAppinput: UITextField!

    @IBAction func addAppButton(_ sender: Any) {
        guard let text = addAppinput.text else {return}
        addAppInteractor.setRatings(for: text) { if ($0 != nil) { self.handleError($0!) } }
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.addAppInteractor.delegate = self
    }
    
    func newAppAdded() {
        self.navigationController?.popViewController(animated: true)
    }
    
    private func handleError(_ error: Error) {
        let alertController = UIAlertController(title: "Error", message: "\(error)", preferredStyle: .alert)
        alertController.addAction(UIAlertAction(title: "Ok", style: UIAlertActionStyle.default, handler: nil))
        self.present(alertController, animated: true, completion: nil)
    }
    
    static func newController() -> AddAppViewController {
        let storyboard = UIStoryboard(name: "Main", bundle: Bundle.main)
        return storyboard.instantiateViewController(withIdentifier: "AddAppViewController") as! AddAppViewController
    }
}