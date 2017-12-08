import Foundation
import UIKit

protocol HomeDataSourceProtocol {
    var homeInteractor: HomeInteractorProtocol {get set}
    var tableView: UITableView {get set}
    
    func loadData()
    func rating(for index: Int) -> Rating
    func contentDidChange()
    func deleteRating(at index: Int) -> Void
}
