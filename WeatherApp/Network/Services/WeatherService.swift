public protocol WeatherServicable {
    func getCurrentForecast() async throws -> String
}

public class WeatherService {
    private let apiClient: NetworkClientable

    public init(apiClient: NetworkClientable) {
        self.apiClient = apiClient
    }
}

extension WeatherService: WeatherServicable {
    public func getCurrentForecast() async throws -> String {
        do {
            let response: String = try await apiClient.request(
                for: WeatherRoute
                    .current(
                        requestData: CurrentRequestData(
                            latitude: "-26.02728405486236",
                            longitude: "28.082204520799934",
                            appId: "9af75ea3a75faa6833cdf0a5295212f8"
                        )
                    )
            )
            return response
        } catch {
            // filter this to a more friendly UI error
            throw error
        }
    }
}
