import XCTest
@testable import SuperHeros
import Moya

class TestMarvelCharacterDetailUseCase: XCTestCase {
    private var usecase: FetchMarvelCharacterDetailUseCase?
    var marvelCharacter: MarvelCharacter?
    
    override func setUpWithError() throws {
        let sut = MarvelCharacterDetailRepoMock()
        usecase = DefaultFetchMarvelCharacterDetailUseCase(marvelCharacterDetailRepository: sut)
        marvelCharacter = try? getArrayFromJson()
    }
    
    func testFetchMarvelCharacterDetail() {
        let expectation = XCTestExpectation(description: "Request to get 1 marvel character")
        
        guard let marvel = marvelCharacter else {
            return
        }
        usecase?.marvelCharacterDetailRepository?.repositoryResult = .success(marvel)
        usecase?.execute(characterId: 1011334) { result in
            switch result {
            case .success(let marvelCharacter):
                XCTAssertNotNil(marvelCharacter)
                XCTAssertEqual(marvelCharacter.data.results.first?.id, 1011334)
                expectation.fulfill()
            case .failure:
                XCTFail("Success expected")
            }
        }
    }
    
    func testFailureFetchMarvelCharacterDetail() {
        usecase?.marvelCharacterDetailRepository?.repositoryResult = .failure(CustomError.cannotConvertToDomainModel)
        let expectation = XCTestExpectation(description: "Request to get failed marvel character")
        usecase?.execute(characterId: 101133122) { result in
            switch result {
            case .success:
                XCTFail("Failure Expected")
            case .failure(let error):
                XCTAssertNotNil(error)
                expectation.fulfill()
            }
        }
    }
}
