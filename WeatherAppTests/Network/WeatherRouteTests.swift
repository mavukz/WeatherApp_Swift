import XCTest
@testable import WeatherApp

final class WeatherRouteTests: XCTestCase {
    func testCurrentForecastRouteIsCorrect() {
        let route = WeatherRoute.current

        XCTAssertEqual(
            route.url.absoluteString,
            "https://api.openweathermap.org/current"
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
