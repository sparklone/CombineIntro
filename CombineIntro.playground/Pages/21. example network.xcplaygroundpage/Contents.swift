import Combine
import UIKit

struct User: Codable {
    let name: String
}
let someURL = URL(string: "https://test-api.com/user?id=10")!
let userNameLabel = UILabel()

URLSession.shared.dataTaskPublisher(for:someURL)
    .retry(1)
    .map({ $0.data })
    .decode(type: User.self, decoder: JSONDecoder())
    .map({ $0.name })
    .replaceError(with: "unknown")
    .assign(to: \.text, on: userNameLabel)
