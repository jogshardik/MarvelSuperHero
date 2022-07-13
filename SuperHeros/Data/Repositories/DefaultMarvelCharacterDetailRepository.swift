import Foundation
import Moya

final class DefaultMarvelCharacterDetailRepository: MarvelCharacterDetailRepo {
    
    private let network: Networkable
    
    init (network: Networkable = NetworkService()) {
        self.network = network
    }
}

extension DefaultMarvelCharacterDetailRepository {
    
    func fetchMarvelCharacterDetail(characterId: Int, completion: @escaping (Result<MarvelCharacter, Error>) -> Void) {
        network.callService(network.getProvider(), target: MultiTarget(MarvelCharacterListProvider.getMarvelCharacterDetail(characterId))) { (marvelCharacter: MarvelCharacter) in
            completion(.success(marvelCharacter))
        } failure: { error in
            completion(.failure(error))
        }
    }
}
