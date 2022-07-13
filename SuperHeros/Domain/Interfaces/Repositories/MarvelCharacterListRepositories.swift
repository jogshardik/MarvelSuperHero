import Foundation

protocol MarvelCharacterListRepositories {
    var repositoryResult: (Result<MarvelCharacter, Error>)? { get set }
    func fetchMarvelCharacterList(offset: Int, limit: Int, completion: @escaping (Result<MarvelCharacter, Error>) -> Void)
}

extension MarvelCharacterListRepositories {
    var repositoryResult: (Result<MarvelCharacter, Error>)? {
        get {
            .failure(CustomError.cannotConvertToDomainModel)
        }
        // swiftlint:disable:next unused_setter_value
        set {}
    }
}
