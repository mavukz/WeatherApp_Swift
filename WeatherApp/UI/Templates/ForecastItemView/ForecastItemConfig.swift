import Foundation

struct ForecastItemConfig: Identifiable {
    let id = UUID()
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
        var attributedString = AttributedString(dayOfWeek)
        attributedString.font = .systemFont(ofSize: 16)
        attributedString.foregroundColor = .white

        return attributedString
    }

    var attributedTemperature: AttributedString {
        var attributedString = AttributedString(temperature)
        attributedString.font = .systemFont(ofSize: 16)
        attributedString.foregroundColor = .white

        return attributedString
    }
}
