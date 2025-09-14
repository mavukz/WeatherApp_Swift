import Foundation

/// This ViewModel is responsible for fetching and mapping data into the view configurations. Also this is where the data state is controlled for this screen
class ForecastViewModel: ObservableObject {
    @Published
    private var _dataState: DataState<ForecastDataModel> = .loading

    private let weatherService: WeatherServiceable

    init(weatherService: WeatherServiceable) {
        self.weatherService = weatherService
    }
}

extension ForecastViewModel {
    var dataState: DataState<ForecastDataModel> {
        _dataState
    }

    func fetchWeatherData() {
        Task { @MainActor [weak self] in
            guard let self else { return }

            do {
                let weatherResponse = try await weatherService
                    .getCurrentWeather()
                let forecastResponse = try await weatherService
                    .getWeatherForecast()
                handleSuccessResponse(
                    weatherResponse,
                    forecastResponse: forecastResponse
                )
            } catch {
                handleFailedResponse(error)
            }
        }
    }
}

// MARK: - Fetch Weather Data
private extension ForecastViewModel {

    func handleSuccessResponse(
        _ weatherResponse: MainWeatherResponse,
        forecastResponse: ForecastResponse
    ) {
        guard let currentTemperature = weatherResponse.main?.temp,
              let minTemperature = weatherResponse.main?.tempMin,
              let maxTemperature = weatherResponse.main?.tempMax,
              let headerDescription = weatherResponse.weather?.first?.main, // double check this if there is multiple
              let responseItems = forecastResponse.list
        else { return }

        let forecast = ForecastDataModel(
            headerTemperatureTitle: "\(String(format: "%.0f", currentTemperature))°",
            headerDescription: headerDescription.rawValue,
            headerForecastConfig: ForecastHeaderItemConfig(
                minimumTemperature: "\(String(format: "%.0f", minTemperature))°",
                currentTemperature: "\(String(format: "%.0f", currentTemperature))°",
                maximumTemperature: "\(String(format: "%.0f", maxTemperature))°"
            ),
            forecastConfigItems: mapForecastConfigItems(
                from: responseItems
            )
        )
        _dataState = .hasData(forecast)
    }

    func mapForecastConfigItems(from responseItems: [ListResponse]) -> [ForecastItemConfig] {
        var configs: [ForecastItemConfig] = []
        var daysOfWeek: [Int] = []
        responseItems.forEach {
            if let temperature = $0.main?.temp,
               let date = getDate(from: $0) {
                let calendar = Calendar.current
                let dayOfWeek = calendar.component(.weekday, from: date)
                let currentDayOfWeek = calendar.component(.weekday, from: Date())

                if daysOfWeek
                    .contains(dayOfWeek) == false &&
                    (0...6).contains(dayOfWeek) &&
                    dayOfWeek != currentDayOfWeek {
                    daysOfWeek.append(dayOfWeek)

                    let dateFormatter = DateFormatter()
                    dateFormatter.dateFormat = "EEEE"
                    let dayOfWeekString = dateFormatter.string(from: date)

                    configs.append(
                        ForecastItemConfig(
                            dayOfWeek: dayOfWeekString,
                            iconName: .partlySunny,
                            temperature: "\(String(format: "%.0f", temperature))°"
                        )
                    )
                }
            }
        }
        return configs
    }

    @MainActor
    func handleFailedResponse(_ error: any Error) {
        let forecast = ForecastDataModel(
            errorDataModel: ForecastErrorDataModel(
                title: "Something went wrong!",
                message: error.localizedDescription // ideally we should print user-friendly messages from API responses
            )
        )
        _dataState = .error(forecast)
    }
}

private extension ForecastViewModel {
    func getDate(from forecastListItem: ListResponse) -> Date? {
        guard let responseDate = forecastListItem.dt else { return nil }

        let timeInterval = TimeInterval(responseDate)
        return Date(timeIntervalSince1970: timeInterval)
    }
}
