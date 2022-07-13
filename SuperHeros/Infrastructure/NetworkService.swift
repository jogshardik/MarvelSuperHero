import Foundation
import Moya

protocol Networkable {
    func callService<T: Codable, P: MoyaProvider<MultiTarget>> (_ provider: P, target: MultiTarget, completion: @escaping ((T) -> Void), failure: @escaping (Error) -> Void)
    func getProvider() -> MoyaProvider<MultiTarget>
}

final class NetworkService: Networkable {
    
    private let provider: MoyaProvider<MultiTarget>
    
    init(provider: MoyaProvider<MultiTarget> = MoyaProvider<MultiTarget>()) {
        self.provider = provider
    }
    
    func getProvider() -> MoyaProvider<MultiTarget> {
        return provider
    }
}

extension NetworkService {
    func callService<T: Codable, P: MoyaProvider<MultiTarget>> (_ provider: P, target: MultiTarget, completion: @escaping ((T) -> Void), failure: @escaping (Error) -> Void) {
        provider.request(target) { result in
            switch result {
            case let .success(response):
                do {
                    let results = try JSONDecoder().decode(T.self, from: response.data)
                    completion(results)
                } catch let error {
                    failure(error)
                }
            case let .failure(error):
                failure(error)
            }
        }
    }
}
