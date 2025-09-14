/// Generated from https://app.quicktype.io/
/// Ideally would validate any in if indeed Int or should it be floating value
public struct WeatherResponse: Codable {
    public let coord: Coord?
    public let weather: [Weather]?
    public let base: String?
    public let main: Main?
    public let visibility: Int?
    public let wind: Wind?
    public let clouds: Clouds?
    public let dt: Int?
    public let sys: Sys?
    public let timezone, id: Int?
    public let name: String?
    public let cod: Int?
}

public struct Clouds: Codable {
    public let all: Int?
}

public struct Coord: Codable {
    public let lon, lat: Double?
}

public struct Main: Codable {
    public let temp, feelsLike, tempMin, tempMax: Double?
    public let pressure, humidity, seaLevel, grndLevel: Int? // confirm if all needs to be Int or double

    enum CodingKeys: String, CodingKey {
        case temp
        case feelsLike = "feels_like"
        case tempMin = "temp_min"
        case tempMax = "temp_max"
        case pressure, humidity
        case seaLevel = "sea_level"
        case grndLevel = "grnd_level"
    }
}

public struct Sys: Codable {
    public let type, id: Int?
    public let country: String?
    public let sunrise, sunset: Int?
}

public struct Weather: Codable {
    public let id: Int?
    public let main, description, icon: String?
}

public struct Wind: Codable {
    public let speed: Double?
    public let deg: Int?
}
