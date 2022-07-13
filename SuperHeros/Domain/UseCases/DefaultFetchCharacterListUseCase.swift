import Foundation

protocol FetchCharacterListUseCase {
    var result: (Result<MarvelCharacterDomainBaseModel, Error>)? { get set }
    func execute(request: MarvelCharacterListRequestParams, completion: @escaping (Result<MarvelCharacterDomainBaseModel, Error>) -> Void)
    var marvelListRepository: MarvelCharacterListRepositories? { get set }
}

extension FetchCharacterListUseCase {
    var result: (Result<MarvelCharacterDomainBaseModel, Error>)? {
        get {
            return .failure(CustomError.cannotConvertToDomainModel)
        }
        // swiftlint:disable:next unused_setter_value
        set {}
    }
}

final class DefaultFetchCharacterListUseCase: FetchCharacterListUseCase {
    
    var marvelListRepository: MarvelCharacterListRepositories?
    
    init(marvelRepository: MarvelCharacterListRepositories) {
        self.marvelListRepository = marvelRepository
    }
    
    func execute(request: MarvelCharacterListRequestParams, completion: @escaping (Result<MarvelCharacterDomainBaseModel, Error>) -> Void) {
        marvelListRepository?.fetchMarvelCharacterList(offset: request.offset, limit: request.limit) { result in
            switch result {
            case (.success(let marvelCharacter)):
                do {
                    let model = try marvelCharacter.convertToDomainModel()
                    completion(.success(model))
                } catch {
                    completion(.failure(CustomError.cannotConvertToDomainModel))
                }
            case (.failure(let error)):
                completion(.failure(error))
            }
        }
    }
}

enum CustomError: Error {
    case cannotConvertToDomainModel
}
