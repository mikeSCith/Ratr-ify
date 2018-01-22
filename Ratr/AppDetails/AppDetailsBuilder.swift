class AppDetails {
    static func build(for rating: Rating) -> AppDetailsViewController {
        let view = AppDetailsViewController(for: rating)
        let presenter = AppDetailsPresenter()
        
        view.presenter = presenter
        
        return view
    }
}
