import Foundation

struct ForecastHeaderItemConfig {
    private let minimumTemperature: String
    private let minimumTemperatureDescription: String
    private let currentTemperature: String
    private let currentTemperatureDescription: String
    private let maximumTemperature: String
    private let maximumTemperatureDescription: String

    init(minimumTemperature: String,
         minimumTemperatureDescription: String,
         currentTemperature: String,
         currentTemperatureDescription: String,
         maximumTemperature: String,
         maximumTemperatureDescription: String) {
        self.minimumTemperature = minimumTemperature
        self.minimumTemperatureDescription = minimumTemperatureDescription
        self.currentTemperature = currentTemperature
        self.currentTemperatureDescription = currentTemperatureDescription
        self.maximumTemperature = maximumTemperature
        self.maximumTemperatureDescription = maximumTemperatureDescription
    }
}

extension ForecastHeaderItemConfig {
    var attributedMinTemperature: AttributedString {
        var attributedString = AttributedString(minimumTemperature)
        attributedString.font = .systemFont(ofSize: 16)
        attributedString.foregroundColor = .white

        return attributedString
    }

    var attributedMinTemperatureDescription: AttributedString {
        var attributedString = AttributedString(minimumTemperatureDescription)
        attributedString.font = .systemFont(ofSize: 16)
        attributedString.foregroundColor = .white

        return attributedString
    }

    var attributedCurrentTemperature: AttributedString {
        var attributedString = AttributedString(currentTemperature)
        attributedString.font = .systemFont(ofSize: 16)
        attributedString.foregroundColor = .white

        return attributedString
    }

    var attributedCurrentTemperatureDescription: AttributedString {
        var attributedString = AttributedString(currentTemperatureDescription)
        attributedString.font = .systemFont(ofSize: 16)
        attributedString.foregroundColor = .white

        return attributedString
    }

    var attributedMaxTemperature: AttributedString {
        var attributedString = AttributedString(maximumTemperature)
        attributedString.font = .systemFont(ofSize: 16)
        attributedString.foregroundColor = .white

        return attributedString
    }

    var attributedMaxTemperatureDescription: AttributedString {
        var attributedString = AttributedString(maximumTemperatureDescription)
        attributedString.font = .systemFont(ofSize: 16)
        attributedString.foregroundColor = .white

        return attributedString
    }
}
