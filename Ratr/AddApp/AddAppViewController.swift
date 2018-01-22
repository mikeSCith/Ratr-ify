import Foundation
import UIKit

protocol AddAppViewControlling: class {
    func presentAlertController(_ alertController: UIAlertController)
    func returnToHome()
}

class AddAppViewController: UIViewController {
    
    var presenter: AddAppPresenting?
    
    @IBOutlet weak var addAppinput: UITextField!

    @IBAction func addAppButton(_ sender: Any) {
        submitNewApp()
    }
    
    init() {
        super.init(nibName: "AddAppViewController", bundle: nil)
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        addAppinput.delegate = self
    }
}

extension AddAppViewController: UITextFieldDelegate {
    
    func textFieldShouldReturn(_ textField: UITextField) -> Bool {
        textField.resignFirstResponder()
        submitNewApp()
        return true
    }
}

extension AddAppViewController: AddAppViewControlling {
    
    func presentAlertController(_ alertController: UIAlertController) {
        present(alertController, animated: true, completion: nil)
    }
    
    func returnToHome() {
        self.navigationController?.popViewController(animated: true)
    }
}

private extension AddAppViewController {
    private func submitNewApp() {
        guard let text = addAppinput.text else {return}
        presenter?.submitNewApp(with: text)
    }
}
