import UIKit

class HomeBuilder {
    
    static func build(
        presenter: HomePresenting = HomePresenter(),
        interactor: HomeViewInteracting = HomeInteractor(),
        view: HomeViewControlling & UIViewController = HomeViewController(),
        splitViewController: PrimarySplitViewController = PrimarySplitViewController(),
        secondNavigationController: UINavigationController = UINavigationController()
        ) -> PrimarySplitViewController {
        
        presenter.interactor = interactor
        presenter.view = view
        
        interactor.presenter = presenter
        
        view.presenter = presenter
        view.detailsNavigation = splitViewController
        
        let homeNavController = UINavigationController(rootViewController: view)
        
        splitViewController.viewControllers = [homeNavController,secondNavigationController]
        return splitViewController
    }
}
