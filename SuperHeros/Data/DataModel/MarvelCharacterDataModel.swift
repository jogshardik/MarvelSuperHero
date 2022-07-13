import Foundation

protocol ConvertToDomainModel {
    associatedtype DomainModel
    func convertToDomainModel() throws -> DomainModel
}
// MARK: - MarvelCharacter
struct MarvelCharacter: Codable {
    let code: Int?
    let status: String?
    let copyright: String?
    let attributionText: String?
    let attributionHTML: String?
    let etag: String?
    let data: MarvelCharacterData?
}

extension MarvelCharacter: ConvertToDomainModel {
    typealias DomainModel = MarvelCharacterDomainBaseModel
    
    func convertToDomainModel() throws -> MarvelCharacterDomainBaseModel {
        guard let dataCode = code, let dataStatus = status, let dataObj = data else {
            throw CustomError.cannotConvertToDomainModel
        }
        
        if let marvelDomainModel = try? dataObj.convertToDomainModel() {
            let domainModel = MarvelCharacterDomainBaseModel(code: dataCode,
                                                             status: dataStatus,
                                                             data: marvelDomainModel)
            return domainModel
        } else {
            throw CustomError.cannotConvertToDomainModel
        }
    }
}

// MARK: - MarvelCharacterData
struct MarvelCharacterData: Codable {
    let offset: Int?
    let limit: Int?
    let total: Int?
    let count: Int?
    let results: [MarvelCharacterDataList]?
}

extension MarvelCharacterData: ConvertToDomainModel {
    typealias DomainModel = MarvelCharacterDomainModel
    
    func convertToDomainModel() throws -> MarvelCharacterDomainModel {
        if let offset = offset,
           let limit = limit,
           let total = total,
           let count = count,
           let domainList = results?.compactMap({ charList in
               return try? charList.convertToDomainModel()
           }) {
            let marvelDomainModel = MarvelCharacterDomainModel(offset: offset,
                                                               limit: limit,
                                                               total: total,
                                                               count: count,
                                                               results: domainList)
            return marvelDomainModel
        } else {
            throw CustomError.cannotConvertToDomainModel
        }
    }
}

// MARK: - MarvelCharacterDataList
struct MarvelCharacterDataList: Codable {
    let id: Int
    let name: String?
    let description: String?
    let modified: String?
    let thumbnail: DataThumbnail?
    let resourceURI: String?
    let comics: ComicsDataModel?
    let series: ComicsDataModel?
    let stories: StoriesDataModel?
    let events: ComicsDataModel?
    let urls: [URLDataElement]?
    
    func convertToDate(modifiedDate: String) -> Date {
        let formatter = DateFormatter()
        formatter.dateFormat = "yyyy-MM-dd'T'HH:mm:ssZ"
        return formatter.date(from: modifiedDate) ?? Date()
    }
    
}

extension MarvelCharacterDataList: ConvertToDomainModel {
    typealias DomainModel = MarvelCharacterDomainList
    
    func convertToDomainModel() throws -> MarvelCharacterDomainList {
        if let thumbData = try? thumbnail?.convertToDomainModel(),
           let comicsData = try? comics?.convertToDomainModel(),
           let seriesData = try? series?.convertToDomainModel(),
           let storiesData = try? stories?.convertToDomainModel(),
           let eventsData = try? events?.convertToDomainModel(),
           let modified = modified,
           let urlsData = urls?.compactMap({ urlElement in
               return try? urlElement.convertToDomainModel()
           }) {
            return MarvelCharacterDomainList(id: id,
                                             name: name ?? "",
                                             description: description ?? "",
                                             modified: convertToDate(modifiedDate: modified),
                                             thumbnail: thumbData,
                                             resourceURI: resourceURI ?? "",
                                             comics: comicsData,
                                             series: seriesData,
                                             stories: storiesData,
                                             events: eventsData,
                                             urls: urlsData)
        } else {
            throw CustomError.cannotConvertToDomainModel
        }
    }
}

// MARK: - ComicsDataModel
struct ComicsDataModel: Codable {
    let available: Int?
    let collectionURI: String?
    let items: [ComicsDataItem]?
    let returned: Int?
}

extension ComicsDataModel: ConvertToDomainModel {
    typealias DomainModel = ComicsDomainModel
    
    func convertToDomainModel() throws -> ComicsDomainModel {
        if let itemsObj = items?.compactMap({ dataItem in
            return try? dataItem.convertToDomainModel()
        }) {
            return ComicsDomainModel(available: available ?? 0, collectionURI: collectionURI ?? "", items: itemsObj, returned: returned ?? 0)
        } else {
            throw CustomError.cannotConvertToDomainModel
        }
    }
}
// MARK: - ComicsDataItem
struct ComicsDataItem: Codable {
    let resourceURI: String?
    let name: String?
}

extension ComicsDataItem: ConvertToDomainModel {
    typealias DomainModel = ComicsDomainItem
    
    func convertToDomainModel() throws -> ComicsDomainItem {
        return ComicsDomainItem(resourceURI: resourceURI ?? "", name: name ?? "")
    }
}

// MARK: - StoriesDataModel
struct StoriesDataModel: Codable {
    let available: Int?
    let collectionURI: String?
    let items: [StoriesDataItem]?
    let returned: Int?
}

extension StoriesDataModel: ConvertToDomainModel {
    typealias DomainModel = StoriesDomainModel
    
    func convertToDomainModel() throws -> StoriesDomainModel {
        if let itemsObj = items?.compactMap({ dataItem in
            return try? dataItem.convertToDomainModel()
        }) {
            return StoriesDomainModel(available: available ?? 0,
                                      collectionURI: collectionURI ?? "" ,
                                      items: itemsObj,
                                      returned: returned ?? 0)
        } else {
            throw CustomError.cannotConvertToDomainModel
        }
    }
}

// MARK: - StoriesDataItem
struct StoriesDataItem: Codable {
    let resourceURI: String?
    let name: String?
}

extension StoriesDataItem: ConvertToDomainModel {
    typealias DomainModel = StoriesDomainItem
    
    func convertToDomainModel() throws -> StoriesDomainItem {
        return StoriesDomainItem(resourceURI: resourceURI ?? "", name: name ?? "")
    }
}

// MARK: - DataThumbnail
struct DataThumbnail: Codable {
    let path: String?
    let thumbnailExtension: String?
    
    enum CodingKeys: String, CodingKey {
        case path
        case thumbnailExtension = "extension"
    }
}

extension DataThumbnail: ConvertToDomainModel {
    typealias DomainModel = ThumbnailDomainModel
    
    func convertToDomainModel() throws -> ThumbnailDomainModel {
        return ThumbnailDomainModel(path: path ?? "", thumbnailExtension: Extension(rawValue: thumbnailExtension ?? "jpg") ?? Extension.jpg)
    }
}

// MARK: - URLDataElement
struct URLDataElement: Codable {
    let type: String?
    let url: String?
}

extension URLDataElement: ConvertToDomainModel {
    typealias DomainModel = URLElement
    
    func convertToDomainModel() throws -> URLElement {
        return URLElement(type: URLType(rawValue: type ?? "detail") ?? URLType.wiki, url: url ?? "")
    }
}
