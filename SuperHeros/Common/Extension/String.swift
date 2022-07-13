import Foundation
import CryptoKit

extension String {
    var toURL: URL {
        return URL(string: self)!
    }
    
    var MD5: String {
        let computed = Insecure.MD5.hash(data: data(using: .utf8)!)
        return computed.map { String(format: "%02hhx", $0) }.joined()
    }
}
