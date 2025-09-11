import Foundation

public protocol Routable {
    var headers: [String: String] { get }
    var path: String { get }
    var url: URL { get }
    var httpMethod: HttpMethod { get }
    var requestBody: Data? { get }

    func encode<T: Encodable>(_ value: T) -> Data?
}

public extension Routable {
    var headers: [String: String] {
        [
            "Content-Type": "application/json",
            "Accept": "application/json",
            "Accept-Encoding": "gzip, deflate, br, zstd",
            "Accept-Language": "en-US,en;q=0.9"
        ]
    }
    
    var requestBody: Data? {
        nil
    }

    func encode<T: Encodable>(_ value: T) -> Data? {
        do {
            let encoder = JSONEncoder()
            return try encoder.encode(value)
        } catch {
            // Log non-fatal if needed
            return nil
        }
    }
}
