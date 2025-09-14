
class ForecastModule {
    static func build() -> ForecastScreenView {
        let apiClient = NetworkClient()
        let service = WeatherService(apiClient: apiClient)
        let viewModel = ForecastViewModel(weatherService: service)
        return ForecastScreenView(viewModel: viewModel)
    }
}
