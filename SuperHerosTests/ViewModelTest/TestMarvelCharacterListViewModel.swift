import XCTest
@testable import SuperHeros
import Moya

class TestMarvelCharacterListViewModel: XCTestCase {
    
    var viewModel: CharacterListViewModel?
    var marvelCharacter: MarvelCharacterDomainBaseModel?
    
    override func setUpWithError() throws {
        // Put setup code here. This method is called before the invocation of each test method in the class.
        
        viewModel = DefaultCharacterListViewModel(action: CharacterListAction(showCharacterDetails: navigateToCharacterDetail))
        viewModel?.characterListUseCase = FetchCharacterListMock()
        marvelCharacter = try? getArrayFromJson()
    }
    
    func testViewDidLoad() {
        guard let marvel = marvelCharacter else {
            return
        }
        viewModel?.characterListUseCase?.result = .success(marvel)
        viewModel?.viewDidLoad()
        
        viewModel?.navigationTitle.observe(on: self) { navTitle in
            XCTAssertNotNil(navTitle)
            XCTAssertEqual(navTitle, "Marvel Heros")
        }
    }
    
    func testPullToRefresh() {
        guard let marvel = marvelCharacter else {
            return
        }
        viewModel?.characterListUseCase?.result = .success(marvel)
        viewModel?.pullToRefresh()
        viewModel?.items.observe(on: self) { listItems in
            XCTAssertNotNil(listItems)
            XCTAssertTrue(listItems.count > 0)
        }
    }
    
    func testLoadMoreData() {
        var listcount: Int = 0
        guard let marvel = marvelCharacter else {
            return
        }
        viewModel?.characterListUseCase?.result = .success(marvel)
        viewModel?.initializeMarvelCharacter(marvelCharacter: marvel)
        viewModel?.items.value = marvel.data.results.map(CharacterListItemViewModel.init)
        listcount = viewModel?.items.value.count ?? 0
        viewModel?.didLoadNextPage(index: 0)
        
        viewModel?.items.observe(on: self) { listItems in
            XCTAssertNotNil(listItems)
            XCTAssertTrue(listItems.count > 0)
            XCTAssertTrue(listItems.count > listcount, "List items should be greater then previous list count")
        }
    }
    
    func testDidSelectRow() {
        guard let marvel = marvelCharacter else {
            return
        }
        viewModel?.characterListUseCase?.result = .success(marvel)
        viewModel?.pullToRefresh()
        viewModel?.didSelectItem(at: 0)
        let actionObject = viewModel?.getActionObject()
        XCTAssertNotNil(actionObject)
    }
    
    // This method gets call when viewModel?.didSelectItem method gets called
    private func navigateToCharacterDetail(character: CharacterListItemViewModel) {
        XCTAssertNotNil(character)
        XCTAssertEqual(character.characterId, 1011334)
    }
    
}

func getArrayFromJson() throws -> MarvelCharacterDomainBaseModel {
    if let getJson = getStubData(fileName: "stub.fetchCharacters") {
        do {
            let results = try JSONDecoder().decode(MarvelCharacter.self, from: getJson)
            if let model = try? results.convertToDomainModel() {
                return model
            } else {
                throw CustomError.cannotConvertToDomainModel
            }
        } catch {
            throw CustomError.cannotConvertToDomainModel
        }
    } else {
        throw CustomError.cannotConvertToDomainModel
    }
}
