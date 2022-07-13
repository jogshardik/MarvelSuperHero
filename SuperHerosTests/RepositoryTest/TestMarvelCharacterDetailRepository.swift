import XCTest
@testable import SuperHeros
import Moya

class TestMarvelCharacterDetailRepository: XCTestCase {

    var sut: MarvelCharacterDetailRepo?
    
    override func setUpWithError() throws {
        // Put setup code here. This method is called before the invocation of each test method in the class.
        let provider = MoyaProvider<MultiTarget>(stubClosure: MoyaProvider.immediatelyStub, callbackQueue: DispatchQueue.main)
        let network = NetworkService(provider: provider)
        sut = DefaultMarvelCharacterDetailRepository(network: network)
    }

    func testFetchMarvelCharacterDetail() {
        let expectation = XCTestExpectation(description: "Request to get 1 marvel character")
        sut?.fetchMarvelCharacterDetail(characterId: 1011334) { result in
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
    
    func testFailureFetchMarvelCharacterDetail() {
        let expectation = XCTestExpectation(description: "Request to get failed marvel character")
        sut?.fetchMarvelCharacterDetail(characterId: 101133122) { result in
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
