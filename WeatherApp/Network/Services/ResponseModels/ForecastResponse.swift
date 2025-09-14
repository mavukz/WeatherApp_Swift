import Foundation

public struct ForecastResponse: Codable {
    public let cod: String?
    public let message, cnt: Int?
    public let list: [ListResponse]?
    public let city: CityResponse?
}

public struct CityResponse: Codable {
    public let id: Int?
    public let name: String?
    public let coord: CoordResponse?
    public let country: String?
    public let population, timezone, sunrise, sunset: Int?
}

public struct ListResponse: Codable {
    public let dt: Int?
    public let main: MainClassResponse?
    public let weather: [WeatherResponse]?
    public let clouds: CloudsResponse?
    public let wind: WindResponse?
    public let visibility: Int?
    public let pop: Double?
    public let rain: RainResponse?
    public let sys: SysResponse?
    public let dtTxt: String?

    enum CodingKeys: String, CodingKey {
        case dt, main, weather, clouds, wind, visibility, pop, rain, sys
        case dtTxt = "dt_txt"
    }
}

public struct MainClassResponse: Codable {
    public let temp, feelsLike, tempMin, tempMax: Double?
    public let pressure, seaLevel, grndLevel, humidity: Int?
    public let tempKf: Double?

    enum CodingKeys: String, CodingKey {
        case temp
        case feelsLike = "feels_like"
        case tempMin = "temp_min"
        case tempMax = "temp_max"
        case pressure
        case seaLevel = "sea_level"
        case grndLevel = "grnd_level"
        case humidity
        case tempKf = "temp_kf"
    }
}

public struct RainResponse: Codable {
    public let the3H: Double?

    enum CodingKeys: String, CodingKey {
        case the3H = "3h"
    }
}

public struct WindResponse: Codable {
    public let speed: Double?
    public let deg: Int?
    public let gust: Double?
}
