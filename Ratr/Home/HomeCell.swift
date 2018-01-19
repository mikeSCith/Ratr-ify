import Foundation
import UIKit

class HomeCell: UITableViewCell {
    
    @IBOutlet weak var iconView: UIImageView!
    @IBOutlet weak var label: UILabel!
    
    func present(rating: Rating) {
        iconView.kf.setImage(with: rating.appIconLarge)
        label.text = rating.title
    }
}
