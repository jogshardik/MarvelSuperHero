import Foundation
import UIKit

class SuperHeroDetailBuilder {
    
    static func navigateToCharacterDetail(character: CharacterListItemViewModel) {
        if let superHeroVC = SuperHeroDetailViewController.instantiateFrom(appStoryboard: AppStoryboard.superHeroDetail) {
            superHeroVC.viewModel = DefaultSuperHeroViewModel(characterModel: character)
            superHeroVC.viewModel?.useCase = DefaultFetchMarvelCharacterDetailUseCase(marvelCharacterDetailRepository: DefaultMarvelCharacterDetailRepository())
            if let appDelegate = UIApplication.shared.delegate, let rootVC = appDelegate.window, let navController = rootVC?.rootViewController as? UINavigationController {
                navController.pushViewController(superHeroVC, animated: true)
            }
        }
    }
}
