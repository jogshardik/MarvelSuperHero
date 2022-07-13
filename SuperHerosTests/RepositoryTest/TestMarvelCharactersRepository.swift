import XCTest
@testable import SuperHeros
import Moya

class TestMarvelCharactersRepository: XCTestCase {

    var sut: MarvelCharacterListRepositories?
    
    override func setUpWithError() throws {
        // Put setup code here. This method is called before the invocation of each test method in the class.
        let provider = MoyaProvider<MultiTarget>(stubClosure: MoyaProvider.immediatelyStub, callbackQueue: DispatchQueue.main)
        let network = NetworkService(provider: provider)
        sut = DefaultMarvelCharacterRepositories(network: network)
    }
    
    func testFetchMarvelCharacterList() {
        let expectation = XCTestExpectation(description: "Request to get 1 marvel character")
        
        sut?.fetchMarvelCharacterList(offset: 0, limit: 1) { result in
            switch result {
            case .success(let marvelCharacter):
                XCTAssertNotNil(marvelCharacter)
                XCTAssertEqual(marvelCharacter.data?.results?.first?.id, 1011334)
                expectation.fulfill()
            case .failure:
                XCTFail("Success expected")
            }
        }
    }
    
    func test_failureFetchMarvelCharacterList() {
        let expectation = XCTestExpectation(description: "Request to get failed marvel character")
        
        sut?.fetchMarvelCharacterList(offset: 0, limit: 0) { result in
            switch result {
            case .success:
                XCTFail("Failure expected")
            case .failure(let error):
                XCTAssertNotNil(error)
                expectation.fulfill()
            }
        }
    }
}
