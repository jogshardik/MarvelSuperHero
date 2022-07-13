import Foundation
import UIKit

/// extension of `UIViewController` that is use for extending the functions and properties
extension UIViewController {
    /// returns the instance of `String` that is use for storyboard identifier
    class var storyboardID: String {
        return "\(self)"
    }
    
    /// It's use for getting the instance of `UIViewController` type
    /// - Parameters:
    ///     - appStoryboard: Input storyboard that containing the view controller
    /// - Returns:
    ///     - Instance of `UIViewController`
    static func instantiateFrom(appStoryboard: AppStoryboard) -> Self? {
        return appStoryboard.viewcontroller(viewcontrollerClass: self)
    }
}
