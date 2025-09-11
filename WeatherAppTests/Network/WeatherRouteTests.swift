import XCTest
@testable import WeatherApp

final class WeatherRouteTests: XCTestCase {
    func testCurrentForecastRouteIsCorrect() {
        let requestData = CurrentRequestData(
            latitude: "100",
            longitude: "200",
            appId: "123"
        )
        let route = WeatherRoute.current(requestData: requestData)

        XCTAssertEqual(
            route.url.absoluteString,
            "https://api.openweathermap.org/data/2.5/weather?lat=100&lon=200&appid=123"
        )
        XCTAssertEqual(route.httpMethod, .get)
        XCTAssertNil(route.requestBody)
    }

    func testForecastRouteIsCorrect() {
        let route = WeatherRoute.forecast(5)

        XCTAssertEqual(route.url.absoluteString, "https://api.openweathermap.org/forecast5")
        XCTAssertEqual(route.httpMethod, .get)
        XCTAssertNil(route.requestBody)
    }
}
