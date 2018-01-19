import Foundation
import UIKit

protocol AddAppViewControlling {
    func presentAlertController(_ alertController: UIAlertController)
    func submitNewApp()
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
        let newPresenter = AddAppPresenter()
        self.presenter = newPresenter
        self.presenter?.interactor = AddAppInteractor(presenter: newPresenter)
        self.presenter?.view = self
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.addAppinput.delegate = self
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
        self.present(alertController, animated: true, completion: nil)
    }
    
    
    func submitNewApp() {
        guard let text = addAppinput.text else {return}
        presenter?.submitNewApp(with: text)
    }
    
    func returnToHome() {
        self.navigationController?.popViewController(animated: true)
    }
}
