import SwiftUI

struct ForecastHeaderItemView: View {
    let viewConfig: ForecastHeaderItemConfig

    var body: some View {
        HStack(alignment: .center) {
            Text(viewConfig.attributedMinTemperature)
                .frame(maxWidth: .infinity, alignment: .center)
            Text(viewConfig.attributedCurrentTemperature)
            Text(viewConfig.attributedMaxTemperature)
                .frame(maxWidth: .infinity, alignment: .center)
        }
    }
}
