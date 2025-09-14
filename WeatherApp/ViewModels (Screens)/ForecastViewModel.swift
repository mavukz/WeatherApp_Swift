import Foundation

/// This ViewModel is responsible for fetching and mapping data into the view configurations. Also this is where the data state is controlled for this screen
class ForecastViewModel: ObservableObject {
    @Published
    private var _dataState: DataState<ForecastDataModel> = .loading

    private let weatherService: WeatherServiceable

    private var currentWeatherResponse: WeatherResponse?

    init(weatherService: WeatherServiceable) {
        self.weatherService = weatherService
    }
}

// MARK: - Fetch Weather Data
private extension ForecastViewModel {
    func fetchCurrentWeather() {
        Task { @MainActor [weak self] in
            guard let self else { return } // log non-fatal as we should have self here always

            do {
                let weatherResponse = try await  self.weatherService.getCurrentWeather()
                currentWeatherResponse = weatherResponse
            } catch {
                handleFailedCurrentWeatherResponse(error)
            }
        }
    }

    func handleSuccessCurrentWeatherResponse(_ weatherResponse: WeatherResponse) {
        guard let currentTemperature = weatherResponse.main?.temp,
              let minTemperature = weatherResponse.main?.tempMin,
              let maxTemperature = weatherResponse.main?.tempMax,
              let headerDescription = weatherResponse.weather?.first?.main, // double check this if there is multiple
              let responseItems = weatherResponse.weather
        else { return }

        let forecast = ForecastDataModel(
            headerTemperatureTitle: "\(String(format: "%.2f", currentTemperature))°",
            headerDescription: headerDescription,
            headerForecastConfig: ForecastHeaderItemConfig(
                minimumTemperature: "\(String(format: "%.2f", minTemperature))°",
                currentTemperature: "\(String(format: "%.2f", currentTemperature))°",
                maximumTemperature: "\(String(format: "%.2f", maxTemperature))°"
            ),
            forecastConfigItems: [] // Forecast api response to populate these
        )
        _dataState = .hasData(forecast)
    }

//    func mapForecastConfigItems(
//        from responseItems: []
//    ) -> [ForecastItemConfig] {
//        responseItems.compactMap {
//            ForecastItemConfig(dayOfWeek: $0., iconName: <#T##ImageName#>, temperature: <#T##String#>)
//        }
//    }

    func handleFailedCurrentWeatherResponse(_ error: any Error) {
        let forecast = ForecastDataModel(
            errorDataModel: ForecastErrorDataModel(
                title: "Something went wrong!",
                message: error.localizedDescription // ideally we should print user-friendly messages from API responses
            )
        )
        _dataState = .error(error)
    }
}
