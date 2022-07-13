import Foundation
import Kingfisher

extension UIImageView {
    
    func setThumbnailImageWith(url: String, imageExtension: String) {
        if let imageUrl = URL(string: url.appending("/landscape_medium.\(imageExtension)")) {
            self.kf.indicatorType = .activity
            self.kf.setImage(with: imageUrl, options: [.transition(.fade(0.2))])
        }
    }
    
    func setPosterImageWith(url: String, imageExtension: String) {
        if let imageUrl = URL(string: url.appending("/landscape_incredible.\(imageExtension)")) {
            self.kf.indicatorType = .activity
            self.kf.setImage(with: imageUrl, options: [.transition(.fade(0.2))])
        }
    }
    
    func setPosterPortrraitImageWith(url: String, imageExtension: String) {
        if let imageUrl = URL(string: url.appending("/portrait_incredible.\(imageExtension)")) {
            self.kf.indicatorType = .activity
            self.kf.setImage(with: imageUrl, options: [.transition(.fade(0.2))])
        }
    }
}
