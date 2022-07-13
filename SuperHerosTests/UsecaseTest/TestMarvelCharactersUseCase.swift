import XCTest
@testable import SuperHeros
import Moya
class TestMarvelCharactersUseCase: XCTestCase {
    
    private var usecase: FetchCharacterListUseCase?
    var marvelCharacter: MarvelCharacter?
    
    override func setUpWithError() throws {
        let sut = MarvelCharacterListRepositoriesMock()
        usecase = DefaultFetchCharacterListUseCase(marvelRepository: sut)
        marvelCharacter = try? getArrayFromJson()
    }
    
    func testFetchMarvelCharacterList() {
        let expectation = XCTestExpectation(description: "Request to get 1 marvel character")
        
        let request = MarvelCharacterListRequestParams(limit: 1, offset: 0)
        guard let marvel = marvelCharacter else {
            return
        }
        usecase?.marvelListRepository?.repositoryResult = .success(marvel)
        usecase?.execute(request: request) { result in
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
    
    func testFailureFetchMarvelCharacterList() {
        let expectation = XCTestExpectation(description: "Request to get failed marvel character")
        
        let request = MarvelCharacterListRequestParams(limit: 0, offset: 0)
        usecase?.marvelListRepository?.repositoryResult = .failure(CustomError.cannotConvertToDomainModel)
        usecase?.execute(request: request) { result in
            switch result {
            case .failure(let error):
                XCTAssertNotNil(error)
                expectation.fulfill()
            case .success:
                XCTFail("Failure expected")
            }
        }
    }
}

func getArrayFromJson() throws -> MarvelCharacter {
    if let getJson = getStubData(fileName: "stub.fetchCharacters") {
        do {
            let results = try JSONDecoder().decode(MarvelCharacter.self, from: getJson)
            return results
        } catch {
            throw CustomError.cannotConvertToDomainModel
        }
    } else {
        throw CustomError.cannotConvertToDomainModel
    }
}
