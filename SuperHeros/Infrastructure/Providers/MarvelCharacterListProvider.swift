import Foundation
import Moya

enum MarvelCharacterListProvider {
    case getMarvelCharacters(MarvelCharacterListRequestParams)
    case getMarvelCharacterDetail(Int)
}

extension MarvelCharacterListProvider: TargetType {
    var baseURL: URL {
        return (AppConstant.currentEnvironment.apiUrl).toURL
    }
    
    var path: String {
        switch self {
        case .getMarvelCharacters:
            return "v1/public/characters"
        case .getMarvelCharacterDetail(let characterId):
            return "v1/public/characters/\(characterId)"
        }
    }
    
    var method: Moya.Method {
        return Method.get
    }
    
    var sampleData: Data {
        switch self {
        case .getMarvelCharacters(let params):
            if params.limit > 0 {
                return getStubData(fileName: "stub.fetchCharacters") ?? Data()
            } else {
                return Data()
            }
        case .getMarvelCharacterDetail(let characterId):
            if characterId == 1011334 {
                return getStubData(fileName: "stub.fetchCharacters") ?? Data()
            } else {
                return Data()
            }
        }
    }
    
    var task: Task {
        switch self {
        case .getMarvelCharacters(let marvelCharacterListRequestParams):
            var dict = getTimeStampAndHash()
            if marvelCharacterListRequestParams.limit > 0 {
                dict["limit"] = marvelCharacterListRequestParams.limit
            }
            if marvelCharacterListRequestParams.offset > 0 {
                dict["offset"] = marvelCharacterListRequestParams.offset
            }
            return .requestParameters(parameters: dict, encoding: URLEncoding.queryString)
        case .getMarvelCharacterDetail:
            let dict = getTimeStampAndHash()
            return .requestParameters(parameters: dict, encoding: URLEncoding.queryString)
        }
    }
    
    var headers: [String: String]? {
        return nil
    }
}

extension TargetType {
    func getTimeStampAndHash() -> [String: Any] {
        var dict = [String: Any]()
        let date = Int(Date().timeIntervalSince1970)
        let combineStr = "\(date)" + "\(AppConstant.currentEnvironment.privateApiKey)" + "\(AppConstant.currentEnvironment.publicApiKey)"
        let hash = combineStr.MD5
        dict["ts"] = date
        dict["hash"] = hash
        dict["apikey"] = AppConstant.currentEnvironment.publicApiKey
        return dict
    }
}

func getStubData(fileName: String) -> Data? {
    if let path = Bundle.main.path(forResource: fileName, ofType: "json") {
        do {
            let data = try Data(contentsOf: URL(fileURLWithPath: path), options: .mappedIfSafe)
            return data
        } catch {
            // handle error
            return nil
        }
    } else {
        return nil
    }
}
