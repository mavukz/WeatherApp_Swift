/// Generated from https://app.quicktype.io/
/// Ideally would validate any in if indeed Int or should it be floating value
public struct MainWeatherResponse: Codable {
    public let coord: CoordResponse?
    public let weather: [WeatherResponse]?
    public let base: String?
    public let main: MainResponse?
    public let visibility: Int?
    public let wind: WindResponse?
    public let clouds: CloudsResponse?
    public let dt: Int?
    public let sys: SysResponse?
    public let timezone, id: Int?
    public let name: String?
    public let cod: Int?
}

public struct CloudsResponse: Codable {
    public let all: Int?
}

public struct CoordResponse: Codable {
    public let lon, lat: Double?
}

public struct MainResponse: Codable {
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

public struct SysResponse: Codable {
    public let type, id: Int?
    public let country: String?
    public let sunrise, sunset: Int?
    public let pod: PodResponse?
}

public enum PodResponse: String, Codable {
    case d = "d"
    case n = "n"
}

public struct WeatherResponse: Codable {
    public let id: Int?
    public let main: MainEnumResponse?
    public let description, icon: String?
}

public enum MainEnumResponse: String, Codable {
    case clear = "Clear"
    case clouds = "Clouds"
    case rain = "Rain"
}
