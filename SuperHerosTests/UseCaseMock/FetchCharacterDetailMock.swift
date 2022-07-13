import Foundation
@testable import SuperHeros

class FetchCharacterDetailMock: FetchMarvelCharacterDetailUseCase {
    var marvelCharacterDetailRepository: MarvelCharacterDetailRepo?
    var result: (Result<MarvelCharacterDomainBaseModel, Error>)?
    
    func execute(characterId: Int, completion: @escaping (Result<MarvelCharacterDomainBaseModel, Error>) -> Void) {
        if let result = result {
            completion(result)
        } else {
            fatalError("Usecase not mocked")
        }
    }
}
