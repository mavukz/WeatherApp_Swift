import SwiftUI

struct ForecastScreenView: View {
    @ObservedObject var viewModel: ForecastViewModel

    var body: some View {
        VStack {
            switch viewModel.dataState {
            case let .hasData(dataModel):
                ScrollView(showsIndicators: false) {
                    LazyVStack {
                        headerView(
                            dataModel.attributedHeaderTemperatureTitle,
                            dataModel.attributedHeaderDescription
                        )

                        VStack(spacing: 16) {
                            if let headerForecastConfig = dataModel.headerForecastConfig {
                                ForecastHeaderItemView(viewConfig: headerForecastConfig)
                                    .padding(.horizontal, 16)
                            }
                            Divider()
                                .frame(maxWidth: .infinity)
                                .background(Color.white)
                            if let forecastConfigItems = dataModel.forecastConfigItems {
                                ForEach(forecastConfigItems) { item in
                                    ForecastItemView(viewConfig: item)
                                        .padding(.horizontal, 16)
                                }
                            }
                        }
                    }
                }
            case .loading:
                ProgressView()
                    .frame(maxWidth: .infinity, maxHeight: .infinity)
            case let .error(dataModel):
                if let _ = dataModel.errorDataModel {
                    // Error view or alert
                    EmptyView()
                        .frame(maxWidth: .infinity, maxHeight: .infinity)
                }
                EmptyView()
                    .frame(maxWidth: .infinity, maxHeight: .infinity)
            }
        }
        .background(Color.gray.opacity(0.8))
        .onAppear {
            viewModel.fetchWeatherData()
        }
    }

    func headerView(_ attributedTitle: AttributedString?, _ attributedSubtitle: AttributedString?) -> some View {
        VStack(alignment: .center, spacing: 8) {
            if let attributedTitle {
                Text(attributedTitle)
            }
            if let attributedSubtitle {
                Text(attributedSubtitle)
            }
        }
        .padding(.vertical, 32)
    }
}
