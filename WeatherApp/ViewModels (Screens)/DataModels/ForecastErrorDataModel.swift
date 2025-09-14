import Foundation

struct ForecastErrorDataModel {
    let title: String
    let message: String
}

extension ForecastErrorDataModel {
    var attributedTitle: AttributedString {
        AttributedString(title)
    }

    var attributedMessage: AttributedString {
        AttributedString(message)
    }
}
