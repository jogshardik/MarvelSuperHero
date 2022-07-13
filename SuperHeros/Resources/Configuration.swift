import Foundation

struct Configuration {
    lazy var environment: Environment = {
        if let configuration = Bundle.main.object(forInfoDictionaryKey: "Configuration") as? String {
            if configuration.range(of: "Debug") != nil {
                return Environment.debug
            } else if configuration.range(of: "Release") != nil {
                return Environment.release
            }
        }
        return Environment.release
    }()
}
