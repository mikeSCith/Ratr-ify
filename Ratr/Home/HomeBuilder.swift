import Foundation
import UIKit

class HomeBuilder {
    
    static func build() -> PrimarySplitViewController {
        let mainStoryboard = UIStoryboard(name: "Main", bundle: nil)

        let view = mainStoryboard.instantiateViewController(withIdentifier: "HomeViewController") as! HomeViewController
        let presenter = HomePresenter()
        let interactor = HomeInteractor()
        
        presenter.interactor = interactor
        presenter.homeView = view
        
        interactor.presenter = presenter
        
        view.presenter = presenter
        
        let homeNavController = UINavigationController(rootViewController: view)
        let secondNavigationController = UINavigationController()
        let splitViewController = PrimarySplitViewController()
        
        view.detailsNavigation = splitViewController
        splitViewController.viewControllers = [homeNavController,secondNavigationController]
        return splitViewController
    }
}
