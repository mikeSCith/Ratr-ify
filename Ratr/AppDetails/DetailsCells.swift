import UIKit

enum DetailsCell {
    case small(key: String, value: String)
    case large(key: String, value: String)
    
    var cell: UITableViewCell {
        switch self {
        case let .small(key, value):
            return buildSmallCell(key: key, value: value)
        case let .large(key, value):
            return buildLargeCell(key: key, value: value)
        }
    }
    
    private func buildSmallCell(key: String, value: String) -> UITableViewCell {
        let cell = Bundle.main.loadNibNamed("DetailsCellSmall", owner: nil, options: nil)?.first! as! DetailsCellSmall
        cell.present(key: key, value: value)
        return cell
    }
    
    private func buildLargeCell(key: String, value: String) -> UITableViewCell {
        let cell = Bundle.main.loadNibNamed("DetailsCellLarge", owner: nil, options: nil)?.first! as! DetailsCellLarge
        cell.present(key: key, value: value)
        return cell
    }
}

