import Foundation

struct CharacterListAction {
    let showCharacterDetails: (CharacterListItemViewModel) -> Void
}

protocol CharacterListViewModelInput {
    func viewDidLoad()
    func didLoadNextPage(index: Int)
    func didSelectItem(at index: Int)
    func pullToRefresh()
    func initializeMarvelCharacter(marvelCharacter: MarvelCharacterDomainBaseModel)
    var characterListUseCase: FetchCharacterListUseCase? { get set }
}

protocol CharacterListViewModelOutput {
    var error: Observable<String> { get }
    var items: Observable<[CharacterListItemViewModel]> { get }
    var navigationTitle: Observable<String> { get }
    var errorTitle: String { get }
    func getActionObject() -> CharacterListAction?
}

protocol CharacterListViewModel: CharacterListViewModelInput, CharacterListViewModelOutput {}

final class DefaultCharacterListViewModel: CharacterListViewModel {
    
    // MARK: - OUTPUT
    let items: Observable<[CharacterListItemViewModel]> = Observable([])
    let navigationTitle: Observable<String> = Observable("")
    var error: Observable<String> = Observable("")
    let errorTitle = NSLocalizedString("Error", comment: "")
    private let actions: CharacterListAction?
    var characterListUseCase: FetchCharacterListUseCase?
    private var marvelCharacter: MarvelCharacterDomainBaseModel?
    init(action: CharacterListAction? = nil) {
        self.actions = action
    }
}

// MARK: - INPUT. View event methods

extension DefaultCharacterListViewModel {
    
    func viewDidLoad() {
        load(offset: 0)
        navigationTitle.value = "Marvel Heros"
    }
    
    func didLoadNextPage(index: Int) {
        if index == items.value.count - 1 {
            guard let total = marvelCharacter?.data.total else { return }
            if total > items.value.count {
                let offset = items.value.count
                load(offset: offset)
            }
        }
    }
    
    func didSelectItem(at index: Int) {
        actions?.showCharacterDetails(items.value[index])
    }
    
    func pullToRefresh() {
        resetData()
        load(offset: 0)
    }
    
    func initializeMarvelCharacter(marvelCharacter: MarvelCharacterDomainBaseModel) {
        self.marvelCharacter = marvelCharacter
    }
    
    func getActionObject() -> CharacterListAction? {
        actions
    }
    // MARK: - Private
    
    private func resetData() {
        items.value.removeAll()
        marvelCharacter = nil
    }
    
    private func appendMarvelCharacter(_ marvelCharacter: MarvelCharacterDomainBaseModel) {
        initializeMarvelCharacter(marvelCharacter: marvelCharacter)
        
        if let marvelList = self.marvelCharacter?.data.results.map(CharacterListItemViewModel.init) {
            items.value += marvelList
        }
    }
    
    private func load(offset: Int) {
        self.characterListUseCase?.execute(request: .init(limit: 20, offset: offset)) { [weak self] result in
            switch result {
            case (.success(let marvelCharacter)):
                self?.appendMarvelCharacter(marvelCharacter)
            case (.failure(let error)):
                self?.handle(error: error)
            }
        }
    }
    
    private func handle(error: Error) {
        self.error.value = error.localizedDescription
    }
}
