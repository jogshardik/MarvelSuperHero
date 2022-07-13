import Foundation
import UIKit

protocol Coordinator: AnyObject {
    var navigationController: UINavigationController { get set }
    func configureRootViewController()
}

class SuperheroListBuilder: Coordinator {
    var navigationController: UINavigationController
    
    init(navigationController: UINavigationController) {
        self.navigationController = navigationController
    }
    func configureRootViewController() {
        if let superHeroListVC = MarvelCharacterListViewController.instantiateFrom(appStoryboard: AppStoryboard.main) {
            superHeroListVC.viewModel = DefaultCharacterListViewModel(action: CharacterListAction(showCharacterDetails: SuperHeroDetailBuilder.navigateToCharacterDetail))
            superHeroListVC.viewModel?.characterListUseCase = DefaultFetchCharacterListUseCase(marvelRepository: DefaultMarvelCharacterRepositories())
            navigationController.pushViewController(superHeroListVC, animated: true)
        }
    }
}
