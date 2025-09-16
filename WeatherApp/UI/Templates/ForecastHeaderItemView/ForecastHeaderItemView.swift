import SwiftUI

struct ForecastHeaderItemView: View {
    let viewConfig: ForecastHeaderItemConfig

    var body: some View {
        HStack(alignment: .center) {
            VStack {
                Text(viewConfig.attributedMinTemperature)
                Text(viewConfig.attributedMinTemperatureDescription)
            }
            VStack {
                Text(viewConfig.attributedCurrentTemperature)
                    .frame(maxWidth: .infinity, alignment: .center)
                Text(viewConfig.attributedCurrentTemperatureDescription)
                    .frame(maxWidth: .infinity, alignment: .center)
            }
            VStack {
                Text(viewConfig.attributedMaxTemperature)
                Text(viewConfig.attributedMaxTemperatureDescription)
            }
        }
    }
}
