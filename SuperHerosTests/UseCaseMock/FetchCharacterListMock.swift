import Foundation
@testable import SuperHeros

class FetchCharacterListMock: FetchCharacterListUseCase {
    var marvelListRepository: MarvelCharacterListRepositories?
    var result: (Result<MarvelCharacterDomainBaseModel, Error>)?
    
    func execute(request: MarvelCharacterListRequestParams, completion: @escaping (Result<MarvelCharacterDomainBaseModel, Error>) -> Void) {
        if let result = result {
            completion(result)
        } else {
            fatalError("Usecase not mocked")
        }
    }
}
