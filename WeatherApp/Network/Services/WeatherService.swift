public protocol WeatherServiceable {
    func getCurrentWeather() async throws -> MainWeatherResponse
    func getWeatherForecast() async throws -> ForecastResponse
}

public class WeatherService {
    private let apiClient: NetworkClientable

    public init(apiClient: NetworkClientable) {
        self.apiClient = apiClient
    }
}

extension WeatherService: WeatherServiceable {
    public func getCurrentWeather() async throws -> MainWeatherResponse {
        do {
            let response: MainWeatherResponse = try await apiClient.request(
                for: WeatherRoute
                    .current(
                        requestData: CurrentRequestData(
                            latitude: "-26.02728405486236",
                            longitude: "28.082204520799934",
                            appId: "9af75ea3a75faa6833cdf0a5295212f8" // bad practise, keep in plist, but even that can be unbundled easy
                        )
                    )
            )
            return response
        } catch {
            // filter this to a more friendly UI error
            throw error
        }
    }

    public func getWeatherForecast() async throws -> ForecastResponse {
        do {
            let response: ForecastResponse = try await apiClient.request(
                for: WeatherRoute
                    .forecast(
                        requestData: CurrentRequestData(
                            latitude: "-26.02728405486236",
                            longitude: "28.082204520799934",
                            appId: "9af75ea3a75faa6833cdf0a5295212f8" // bad practise, keep in plist, but even that can be unbundled easy
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
