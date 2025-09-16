import Foundation
import SwiftUICore

/// This is the representation of all the data for this specific screen, all the models for all the components for this screen. Similar to Configs to template, this is for the entire screen.
/// Keeping all these optionals so that if there was a service error, then only service error data is presented
struct ForecastDataModel {
    private let headerTemperatureTitle: String?
    private let headerDescription: String?
    let headerForecastConfig: ForecastHeaderItemConfig?
    let forecastConfigItems: [ForecastItemConfig]?
    let errorDataModel: ForecastErrorDataModel?

    init(headerTemperatureTitle: String? = nil,
         headerDescription: String? = nil,
         headerForecastConfig: ForecastHeaderItemConfig? = nil,
         forecastConfigItems: [ForecastItemConfig]? = nil,
         errorDataModel: ForecastErrorDataModel? = nil) {
        self.headerTemperatureTitle = headerTemperatureTitle
        self.headerDescription = headerDescription
        self.headerForecastConfig = headerForecastConfig
        self.forecastConfigItems = forecastConfigItems
        self.errorDataModel = errorDataModel
    }
}

extension ForecastDataModel {
    var attributedHeaderTemperatureTitle: AttributedString? {
        guard let headerTemperatureTitle else { return nil }

        var attributedString = AttributedString(headerTemperatureTitle)
        attributedString.font = Font.system(size: 48, weight: .bold)
        attributedString.foregroundColor = .white

        return attributedString
    }

    var attributedHeaderDescription: AttributedString? {
        guard let headerDescription else { return nil }

        var attributedString = AttributedString(headerDescription)
        attributedString.font = Font.system(size: 32, weight: .semibold)
        attributedString.foregroundColor = .white

        return attributedString
    }
}
