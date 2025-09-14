import SwiftUI

struct ForecastScreenView: View {

    @ObservedObject var viewModel: ForecastViewModel

    var body: some View {

    }

    // Did not think this could be as reusable as item template views, if so in future, then extraction won't be much of a challenge
    var headerView: some View {
        VStack(alignment: .center, spacing: 16) {
            Text("")
        }
        .padding(.vertical, 32)
    }
}
