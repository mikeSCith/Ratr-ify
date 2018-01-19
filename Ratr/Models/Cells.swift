import Foundation
import UIKit
import Kingfisher

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

class ReviewCell: UITableViewCell {
    
    @IBOutlet weak var keyLabel: UILabel!
    @IBOutlet weak var valueLabel: UILabel!
    
    func present(review: Review) {
        keyLabel.text = review.title
        valueLabel.text = review.rating
    }
}

class RatingCell: UIView {
    
    func ratingString(for stars: Float) -> NSMutableAttributedString {
        let attachment = NSTextAttachment()
        attachment.image = UIImage(named: "full-star.png")
        let attachmentString = NSAttributedString(attachment: attachment)
        let ratingString = NSMutableAttributedString()
        
        for _ in stride(from: 1.0, to: stars + 0.1, by: 1.0 ){
            ratingString.append(attachmentString)
        }
        if stars.truncatingRemainder(dividingBy: 1.0) != 0 {
            let halfStarAttachment = NSTextAttachment()
            halfStarAttachment.image = UIImage(named: "half-star.png")
            let attachmentHalfStarString = NSAttributedString(attachment: halfStarAttachment)
            ratingString.append(attachmentHalfStarString)
        }
        if stars < 4.1 {
            let emptyStarAttachment = NSTextAttachment()
            emptyStarAttachment.image = UIImage(named: "empty-star.png")
            let attachmentEmptyStarString = NSAttributedString(attachment: emptyStarAttachment)
            for _ in stride(from: 0, to: 4.1 - stars, by: 1.0) {
                ratingString.append(attachmentEmptyStarString)
            }
        }
        return ratingString
    }
    
}

class DetailsHeaderCell: RatingCell {
    
    @IBOutlet weak var iconView: UIImageView!
    @IBOutlet weak var label: UILabel!
    @IBOutlet weak var ratingBar: UILabel!
    
    func present(rating: Rating) {
        ratingBar.attributedText = ratingString(for: rating.overallAverageRating)
        iconView.kf.setImage(with: rating.appIconLarge)
        label.text = rating.title
    }
}

class ReviewDetailsHeaderCell: RatingCell {
    
    @IBOutlet weak var titleLabel: UILabel!
    @IBOutlet weak var ratingBar: UILabel!
    @IBOutlet weak var labelValue: UILabel!
    
    func present(for stars: String, with title: String, with comment: String) {
        ratingBar.attributedText = ratingString(for: Float(stars)!)
        titleLabel.text = title
        labelValue.text = comment
    }
}

class ReviewDetailsCell: UITableViewCell {
    
    @IBOutlet weak var keyValue: UILabel!
    @IBOutlet weak var labelValue: UILabel!
    
    func present(key: String, value: String ){
        keyValue.text = key
        labelValue.text = value
    }
}
