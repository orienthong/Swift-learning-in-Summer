import Foundation

public struct App: Decodable {
    public let name: String
    public let link: String
    
    public init?(json: JSON) {
        guard let container: JSON = "im:name" <~~ json,
            let id: JSON = "id" <~~ json else {
                return nil
        }
        guard let name: String = "label" <~~ container,
            link: String = "label" <~~ id else {
                return nil
        }
        self.name = name
        self.link = link
    }
}