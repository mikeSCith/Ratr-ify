import Foundation

protocol HomeInteractorProtocol {
    var ratings: [Rating] {get}
    weak var delegate: HomeInteractorDelegate? {get set}
    func loadRatingData()
    func deleteRatingData(at index: Int)
}
