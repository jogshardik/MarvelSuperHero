import Foundation

protocol FetchMarvelCharacterDetailUseCase {
    var result: (Result<MarvelCharacterDomainBaseModel, Error>)? { get set }
    func execute(characterId: Int, completion: @escaping (Result<MarvelCharacterDomainBaseModel, Error>) -> Void)
    var marvelCharacterDetailRepository: MarvelCharacterDetailRepo? { get set }
}

extension FetchMarvelCharacterDetailUseCase {
    var result: (Result<MarvelCharacterDomainBaseModel, Error>)? {
        get {
            return .failure(CustomError.cannotConvertToDomainModel)
        }
        // swiftlint:disable:next unused_setter_value
        set {}
    }
}

final class DefaultFetchMarvelCharacterDetailUseCase: FetchMarvelCharacterDetailUseCase {
    
    var marvelCharacterDetailRepository: MarvelCharacterDetailRepo?
    
    init(marvelCharacterDetailRepository: MarvelCharacterDetailRepo = DefaultMarvelCharacterDetailRepository()) {
        self.marvelCharacterDetailRepository = marvelCharacterDetailRepository
    }
    
    func execute(characterId: Int, completion: @escaping (Result<MarvelCharacterDomainBaseModel, Error>) -> Void) {
        marvelCharacterDetailRepository?.fetchMarvelCharacterDetail(characterId: characterId) { result in
            switch result {
            case .success(let response):
                if let model = try? response.convertToDomainModel() {
                    completion(.success(model))
                } else {
                    completion(.failure(CustomError.cannotConvertToDomainModel))
                }
            case .failure(let error):
                completion(.failure(error))
            }
        }
    }
    
}
