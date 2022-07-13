import Foundation
import UIKit

enum AppStoryboard: String {
    // MARK: App storyboard cases.
    /// It is use for main storyboard
    case main = "Main"
    case superHeroDetail = "SuperHeroDetail"
    // MARK: Variables
    var instance: UIStoryboard {
        return UIStoryboard(name: rawValue, bundle: Bundle.main)
    }
    // MARK: functions
    /// - Returns: Current instance of the viewcontroller from current storyboard
    func viewcontroller<T: UIViewController> (viewcontrollerClass: T.Type) -> T? {
        let storyboardID = (viewcontrollerClass as UIViewController.Type).storyboardID
        return instance.instantiateViewController(withIdentifier: storyboardID) as? T
    }
    /// - Returns: Initial viewcontroller from current storyboard
    func initialViewController() -> UIViewController? {
        return instance.instantiateInitialViewController()
    }
}
