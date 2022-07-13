import Foundation
@testable import SuperHeros

class MarvelCharacterDetailRepoMock: MarvelCharacterDetailRepo {
    
    var repositoryResult: (Result<MarvelCharacter, Error>)?
    
    func fetchMarvelCharacterDetail(characterId: Int, completion: @escaping (Result<MarvelCharacter, Error>) -> Void) {
        if let result = repositoryResult {
            completion(result)
        } else {
            fatalError("repository not mocked")
        }
    }
}
