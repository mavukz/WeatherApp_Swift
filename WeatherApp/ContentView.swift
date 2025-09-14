import SwiftUI

struct ContentView: View {
    var body: some View {
        VStack {
            Image(systemName: "globe")
                .imageScale(.large)
                .foregroundStyle(.tint)
            Text("Hello, world!")
        }
        .padding()
        .task {
            let service = WeatherService(apiClient: NetworkClient())
            let results = try? await service.getWeatherForecast()
            print(results ?? "")
        }
    }
}
