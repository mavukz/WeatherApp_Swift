import SwiftUI

struct ForecastScreenView: View {
    @ObservedObject var viewModel: ForecastViewModel

    var body: some View {
        ScrollView(showsIndicators: false) {
            switch viewModel.dataState {
            case let .hasData(dataModel):
                LazyVStack {
                    headerView(
                        dataModel.attributedHeaderTemperatureTitle,
                        dataModel.attributedHeaderDescription
                    )

                    VStack(spacing: 0) {
                        if let headerForecastConfig = dataModel.headerForecastConfig {
                            ForecastHeaderItemView(viewConfig: headerForecastConfig)
                        }
                        Divider()
                            .background(Color.white)
                            .frame(maxWidth: .infinity)
                        if let forecastConfigItems = dataModel.forecastConfigItems {
                            ForEach(forecastConfigItems) { item in
                                ForecastItemView(viewConfig: item)
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
        .onAppear {
            viewModel.fetchWeatherData()
        }
    }

    func headerView(_ attributedTitle: AttributedString?, _ attributedSubtitle: AttributedString?) -> some View {
        VStack(alignment: .center, spacing: 16) {
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
