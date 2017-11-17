
import Kingfisher

protocol ImageClientProtocol {
    func getImage(for view: UIImageView, from url: String)
}

class ImageClient: ImageClientProtocol {
    func getImage(for view: UIImageView, from url: String) {
        let url = URL(string: url)
        view.kf.setImage(with: url)
    }
}
