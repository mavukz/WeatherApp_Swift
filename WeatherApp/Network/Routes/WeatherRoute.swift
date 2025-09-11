import Foundation

public enum WeatherRoute {
    case current(requestData: CurrentRequestData)
    case forecast(_ days: Int)
}

extension WeatherRoute: Routable {
    var host: String {
        "https://api.openweathermap.org"
    }

    public var path: String {
        switch self {
        case .current:
            "/data/2.5/weather"
        case let .forecast(days):
            "/forecast\(days)"
        }
    }

    public var url: URL {
        guard var urlComponents = URLComponents(string: host) else {
            preconditionFailure("Invalid URL \(host)")
        }
        urlComponents.path = path

        switch self {
        case let .current(requestData):
            urlComponents.queryItems = [
                URLQueryItem(
                    name: "lat",
                    value: requestData.latitude
                ),
                URLQueryItem(
                    name: "lon",
                    value: requestData.longitude
                ),
                URLQueryItem(name: "appid", value: requestData.appId)
            ]
        default: break
        }

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
