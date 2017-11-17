import Foundation
import UIKit
import AARatingBar
import Kingfisher

class HomeCell: UITableViewCell {
    
    
    @IBOutlet weak var ratingBar: AARatingBar!
    @IBOutlet weak var iconView: UIImageView!
    @IBOutlet weak var label: UILabel!
    
    func present(rating: Rating) {
        ratingBar.updateRating(rating.overallAverageRating)
        iconView.kf.setImage(with: rating.appIconLarge)
        label.text = rating.title
    }
    

}

class DetailsHeaderCell: UIView{
    
    @IBOutlet weak var ratingBar: AARatingBar!
    @IBOutlet weak var iconView: UIImageView!
    @IBOutlet weak var label: UILabel!
    
    
    func present(rating: Rating) {
        ratingBar.updateRating(rating.overallAverageRating)
        iconView.kf.setImage(with: rating.appIconLarge)
        label.text = rating.title
    }
}

class DetailsCellSmall: UITableViewCell {
    
    @IBOutlet weak var keyLabel: UILabel!
    @IBOutlet weak var valueLabel: UILabel!
    
    func present(key: String, value: String) {
        keyLabel.text = key
        valueLabel.text = value
    }
}

class DetailsCellLarge: UITableViewCell {
    
    @IBOutlet weak var keyLabel: UILabel!
    @IBOutlet weak var valueLabel: UILabel!
    
    func present(key: String, value: String) {
        keyLabel.text = key
        valueLabel.text = value
    }
    
}

class DetailsFooterCell: UITabBar {
    
}
