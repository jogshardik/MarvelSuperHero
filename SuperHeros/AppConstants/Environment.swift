import Foundation

enum Environment: String {
    case debug = "Debug"
    case release = "Release"
    
    var apiUrl: String {
        return "https://gateway.marvel.com/"
    }
    
    var publicApiKey: String {
        return "014703108eeb471b560d0466a9f87eb3"
    }
    
    var privateApiKey: String {
        return "c4ac3d65074160dce9a5a5594f63dd44bd4f2c6d"
    }
}
