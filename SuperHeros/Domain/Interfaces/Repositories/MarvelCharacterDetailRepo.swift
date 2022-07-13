import Foundation

protocol MarvelCharacterDetailRepo {
    var repositoryResult: (Result<MarvelCharacter, Error>)? { get set }
    func fetchMarvelCharacterDetail(characterId: Int, completion: @escaping (Result<MarvelCharacter, Error>) -> Void)
}

extension MarvelCharacterDetailRepo {
    var repositoryResult: (Result<MarvelCharacter, Error>)? {
        get {
            .failure(CustomError.cannotConvertToDomainModel)
        }
        // swiftlint:disable:next unused_setter_value
        set {}
    }
}
