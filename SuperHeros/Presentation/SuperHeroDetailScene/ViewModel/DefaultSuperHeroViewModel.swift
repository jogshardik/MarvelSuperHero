import Foundation

struct SuperHeroViewModel {
    let characterImage: String
    let characterName: String
    let characterDescription: String
    let characterPosterExtension: String
    let characterId: Int
    
    init(charater: CharacterListItemViewModel) {
        self.characterName = charater.title
        self.characterImage = charater.posterImagePath ?? ""
        self.characterPosterExtension = charater.imageExtension ?? ""
        self.characterDescription = charater.overview
        self.characterId = charater.characterId
    }
    
    init() {
        characterName = ""
        characterImage = ""
        characterId = 0
        characterDescription = ""
        characterPosterExtension = ""
    }
}
protocol SuperHeroDetailViewModelInput {
    var characterModel: CharacterListItemViewModel? { get }
    func viewDidLoad()
    func loadData()
    var useCase: FetchMarvelCharacterDetailUseCase? { get set }
}

protocol SuperHeroDetailOutputOutput {
    var superHeroModel: Observable<SuperHeroViewModel>? { get }
    var error: Observable<String> { get }
    var navigationTitle: Observable<String> { get }
    var errorTitle: String { get }
}

protocol SuperHeroDetailViewModel: SuperHeroDetailOutputOutput, SuperHeroDetailViewModelInput {}

final class DefaultSuperHeroViewModel: SuperHeroDetailViewModel {
    var superHeroModel: Observable<SuperHeroViewModel>? = Observable(SuperHeroViewModel())
    var characterModel: CharacterListItemViewModel?
    
    // MARK: - OUTPUT
    let navigationTitle: Observable<String> = Observable("")
    var error: Observable<String> = Observable("")
    let errorTitle = NSLocalizedString("Error", comment: "")
    
    var useCase: FetchMarvelCharacterDetailUseCase?
    
    init(characterModel: CharacterListItemViewModel) {
        self.characterModel = characterModel
    }
    
    func loadData() {
        if let characterId = characterModel?.characterId {
            loadData(characterId: characterId)
        }
    }
    func viewDidLoad() {
        if let character = characterModel {
            superHeroModel?.value = SuperHeroViewModel(charater: character)
            navigationTitle.value = "\(superHeroModel?.value.characterName ?? "")"
        } else {
            navigationTitle.value = "Detail"
        }
    }
    
    private func loadData(characterId: Int) {
        useCase?.execute(characterId: characterId) { [weak self] result in
            switch result {
            case .success(let marvel):
                let marvelList = marvel.data.results.map(CharacterListItemViewModel.init)
                if let superHeroModel = marvelList.first.map(SuperHeroViewModel.init) {
                    self?.superHeroModel?.value = superHeroModel
                }
            case.failure(let error):
                self?.handle(error: error)
            }
        }
    }
    
    private func handle(error: Error) {
        self.error.value = error.localizedDescription
    }
}
