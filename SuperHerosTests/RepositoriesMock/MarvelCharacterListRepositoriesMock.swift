import Foundation
@testable import SuperHeros

class MarvelCharacterListRepositoriesMock: MarvelCharacterListRepositories {
    
    var repositoryResult: (Result<MarvelCharacter, Error>)?
    
    func fetchMarvelCharacterList(offset: Int, limit: Int, completion: @escaping (Result<MarvelCharacter, Error>) -> Void) {
        if let result = repositoryResult {
            completion(result)
        } else {
            fatalError("repository not mocked")
        }
    }
}
