import SwiftUI

struct ForecastItemView: View {
    let viewConfig: ForecastItemConfig

    var body: some View {
        HStack(alignment: .center) {
            Text(viewConfig.attributedDayOfWeek)
                .frame(maxWidth: .infinity, alignment: .leading)
            Image(imageName: viewConfig.iconName)
                .frame(width: 12, height: 12)
            Text(viewConfig.attributedTemperature)
                .frame(maxWidth: .infinity, alignment: .trailing)
        }
    }
}
