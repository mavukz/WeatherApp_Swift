import Foundation

struct ForecastHeaderItemConfig {
    private let minimumTemperature: String
    private let currentTemperature: String
    private let maximumTemperature: String

    init(minimumTemperature: String,
         currentTemperature: String,
         maximumTemperature: String) {
        self.minimumTemperature = minimumTemperature
        self.currentTemperature = currentTemperature
        self.maximumTemperature = maximumTemperature
    }
}

extension ForecastHeaderItemConfig {
    var attributedMinTemperature: AttributedString {
        AttributedString(minimumTemperature)
    }

    var attributedCurrentTemperature: AttributedString {
        AttributedString(currentTemperature)
    }

    var attributedMaxTemperature: AttributedString {
        AttributedString(maximumTemperature)
    }
}
