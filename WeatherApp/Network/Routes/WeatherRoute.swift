import Foundation

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
            "/current"
        case let .forecast(days):
            "/forecast\(days)"
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
