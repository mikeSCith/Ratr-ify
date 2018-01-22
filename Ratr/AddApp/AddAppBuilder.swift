class AddApp {
    static func build() -> AddAppViewController {
        let view = AddAppViewController()
        let presenter = AddAppPresenter()
        let interactor = AddAppInteractor()
        
        view.presenter = presenter
        interactor.presenter = presenter
        
        presenter.interactor = interactor
        presenter.view = view
        
        return view
    }
}
