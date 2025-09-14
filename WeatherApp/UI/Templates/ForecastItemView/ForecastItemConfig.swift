import Foundation

struct ForecastItemConfig {
    private let dayOfWeek: String
    let iconName: ImageName
    private let temperature: String

    init(dayOfWeek: String, iconName: ImageName, temperature: String) {
        self.dayOfWeek = dayOfWeek
        self.iconName = iconName
        self.temperature = temperature
    }
}

extension ForecastItemConfig {
    var attributedDayOfWeek: AttributedString {
        AttributedString(dayOfWeek) // customize font here
    }

    var attributedTemperature: AttributedString {
        AttributedString(temperature)
    }
}
