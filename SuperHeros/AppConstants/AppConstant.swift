import Foundation

struct AppConstant {
    static var currentEnvironment: Environment {
        var config = Configuration()
        return config.environment
    }
    
    struct MarvelCharacterListViewController {
        static let characterListTableViewController = "CharacterListTableViewController"
    }
}
