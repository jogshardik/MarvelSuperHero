import Foundation

// MARK: - MarvelCharacterDomainBaseModel
struct MarvelCharacterDomainBaseModel {
    let code: Int
    let status: String
    let data: MarvelCharacterDomainModel
}

// MARK: - MarvelCharacterDomainModel
struct MarvelCharacterDomainModel {
    let offset: Int
    let limit: Int
    let total: Int
    let count: Int
    let results: [MarvelCharacterDomainList]
}

// MARK: - MarvelCharacterDomainList
struct MarvelCharacterDomainList {
    let id: Int
    let name: String
    let description: String
    let modified: Date
    let thumbnail: ThumbnailDomainModel
    let resourceURI: String
    let comics: ComicsDomainModel
    let series: ComicsDomainModel
    let stories: StoriesDomainModel
    let events: ComicsDomainModel
    let urls: [URLElement]
}

// MARK: - ComicsDomainModel
struct ComicsDomainModel {
    let available: Int
    let collectionURI: String
    let items: [ComicsDomainItem]
    let returned: Int
}

// MARK: - ComicsDomainItem
struct ComicsDomainItem {
    let resourceURI: String
    let name: String
}

// MARK: - StoriesDomainModel
struct StoriesDomainModel {
    let available: Int
    let collectionURI: String
    let items: [StoriesDomainItem]
    let returned: Int
}

// MARK: - StoriesDomainItem
struct StoriesDomainItem {
    let resourceURI: String
    let name: String
}

// MARK: - ThumbnailDomainModel
struct ThumbnailDomainModel {
    let path: String
    let thumbnailExtension: Extension
}

enum Extension: String {
    case gif
    case jpg
    case png
}

// MARK: - URLElement
struct URLElement {
    let type: URLType
    let url: String
}

enum URLType: String {
    case comiclink
    case detail
    case wiki
}
