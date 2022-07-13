import Foundation
import Moya

final class DefaultMarvelCharacterRepositories {
    private let network: Networkable
    
    init(network: Networkable = NetworkService()) {
        self.network = network
    }
}

extension DefaultMarvelCharacterRepositories: MarvelCharacterListRepositories {
    func fetchMarvelCharacterList(offset: Int, limit: Int, completion: @escaping (Result<MarvelCharacter, Error>) -> Void) {
        let request = MarvelCharacterListRequestParams(limit: limit, offset: offset)
        network.callService(network.getProvider(), target: MultiTarget(MarvelCharacterListProvider.getMarvelCharacters(request))) { (marvel: MarvelCharacter) in
            completion(.success(marvel))
        } failure: { error in
            completion(.failure(error))
        }
    }
}

struct MarvelCharacterListRequestParams: Encodable {
    var limit: Int
    var offset: Int
}
