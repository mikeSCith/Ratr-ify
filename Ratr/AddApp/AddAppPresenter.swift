import UIKit

protocol AddAppPresenting: class {
    var interactor: AddAppInteracting? { get set }
    var view: AddAppViewControlling? { get set }
    var ratings: [Rating] { get set }
    func submitNewApp(with id: String)
}

class AddAppPresenter: AddAppPresenting {
    

    var interactor: AddAppInteracting?
    weak var view: AddAppViewControlling?
    
    var ratings: [Rating] = [] {
        didSet {
            interactor?.saveRatings(with: ratings)
            view?.returnToHome()
        }
    }
    
    func submitNewApp(with id: String) {
        interactor?.setRatings(for: id) { if ($0 != nil) { self.handleError($0!) } }
    }
    
    private func handleError(_ error: Error) {
        let alertController = UIAlertController(title: "Error", message: "\(error)", preferredStyle: .alert)
        alertController.addAction(UIAlertAction(title: "Ok", style: UIAlertActionStyle.default, handler: nil))
        view?.presentAlertController(alertController)
    }
}
