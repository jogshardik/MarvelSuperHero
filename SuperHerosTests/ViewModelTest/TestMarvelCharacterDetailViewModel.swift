import XCTest
@testable import SuperHeros
import Moya

class TestMarvelCharacterDetailViewModel: XCTestCase {
    
    var viewModel: SuperHeroDetailViewModel?
    var marvelCharacter: MarvelCharacterDomainBaseModel?
    
    override func setUpWithError() throws {
        // Put setup code here. This method is called before the invocation of each test method in the class.
        let characterItemViewModel = CharacterListItemViewModel(characterId: 1011334,
                                                                title: "3-D Man",
                                                                overview: "",
                                                                releaseDate: "2014-04-29T14:18:17-0400",
                                                                posterImagePath: "http://i.annihil.us/u/prod/marvel/i/mg/c/e0/535fecbbb9784",
                                                                imageExtension: "jpg")
        viewModel = DefaultSuperHeroViewModel(characterModel: characterItemViewModel)
        viewModel?.useCase = FetchCharacterDetailMock()
        marvelCharacter = try? getArrayFromJson()
    }
    
    func testViewDidLoad() {
        guard let marvel = marvelCharacter else {
            return
        }
        viewModel?.useCase?.result = .success(marvel)
        viewModel?.viewDidLoad()
        
        viewModel?.navigationTitle.observe(on: self) { navTitle in
            XCTAssertNotNil(navTitle)
            XCTAssertEqual(navTitle, "3-D Man")
        }
    }
    
    func testLoadData() {
        guard let marvel = marvelCharacter else {
            return
        }
        viewModel?.useCase?.result = .success(marvel)
        viewModel?.loadData()
        viewModel?.superHeroModel?.observe(on: self) { superHero in
            XCTAssertNotNil(superHero)
            XCTAssertEqual(superHero.characterId, 1011334)
            XCTAssertEqual(superHero.characterName, "3-D Man")
        }
    }
}
