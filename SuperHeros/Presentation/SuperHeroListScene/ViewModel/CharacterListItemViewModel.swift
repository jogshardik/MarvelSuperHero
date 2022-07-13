import Foundation

struct CharacterListItemViewModel: Equatable {
    let characterId: Int
    let title: String
    let overview: String
    let releaseDate: String
    let posterImagePath: String?
    let imageExtension: String?
}

extension CharacterListItemViewModel {
    
    init(characters: MarvelCharacterDomainList) {
        characterId = characters.id
        title = characters.name
        posterImagePath = characters.thumbnail.path
        imageExtension = characters.thumbnail.thumbnailExtension.rawValue
        overview = characters.description
        releaseDate = dateFormatter.string(from: characters.modified)
    }
}

private let dateFormatter: DateFormatter = {
    let formatter = DateFormatter()
    formatter.dateStyle = .medium
    return formatter
}()
