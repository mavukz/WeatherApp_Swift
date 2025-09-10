import Foundation

public protocol RouteProvider {
    var headers: [String: String] { get }
    var path: String { get }
    var url: URL { get }
    var httpMethod: HttpMethod { get }
    var requestBody: Data? { get }
    
    func encode<T: Encodable>(_ value: T) -> Data?
}

public extension RouteProvider {
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

public enum WeatherRoute {
    case current
    case forecast(_ days: Int)
}

extension WeatherRoute: RouteProvider {
    var host: String {
        "https://api.openweathermap.org"
    }
    
    public var path: String {
        switch self {
        case .current:
            "current"
        case let .forecast(days):
            "forecast\(days)"
        }
    }
    
    public var url: URL {
        guard var urlComponents = URLComponents(string: host) else {
            preconditionFailure("Invalid URL \(host)")
        }
        urlComponents.path = path
        
        guard let url = urlComponents.url else {
            preconditionFailure("Invalid URL components\(urlComponents)")
        }
        
        return url
    }
    
    public var httpMethod: HttpMethod {
        switch self {
        case .current, .forecast:
            return .get
        }
    }
}
