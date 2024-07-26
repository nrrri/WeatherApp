//
//  WeatherAPI.swift
//  WeatherApp
//
//  Created by Narissorn Chowarun on 2024-07-25.
//

import Foundation

struct WeatherAPIResponse: Codable, Equatable {
    static func == (lhs: WeatherAPIResponse, rhs: WeatherAPIResponse) -> Bool {
        return lhs.id == rhs.id
    }
    
    let coord: Coord?
    let weather: [WeatherStruct]?
    let base: String?
    let main: Main?
    let visibility: Int?
    let wind: Wind?
    let clouds: Clouds?
    let dt: Int?
    let sys: WeatherSys?
    let timezone: Int?
    let id: Int?
    let name: String?
    let cod: Int?
    
    static let `default` = WeatherAPIResponse(coord: nil, weather: nil, base: nil, main: nil, visibility: nil, wind: nil, clouds: nil, dt: nil, sys: nil, timezone: nil, id: nil, name: "Invalid or city not found", cod: nil)
}

struct Coord: Codable {
    let lon: Double?
    let lat: Double?
}

struct WeatherStruct: Codable {
    let id: Int?
    let main: String?
    let description: String?
    let icon: String?
}

struct Main: Codable {
    let temp:Double?
    let feelsLike: Double?
    let tempMin: Double?
    let tempMax: Double?
    let pressure: Int?
    let humidity: Int?
    
    enum CodingKeys: String, CodingKey {
        case temp = "temp"
        case feelsLike = "feels like"
        case tempMin = "temp_min"
        case tempMax = "temp_max"
        case pressure = "pressure"
        case humidity = "humidity"
    }
}

struct Wind: Codable {
    let speed: Double?
    let deg: Double?
    let gust: Double?
}

struct Clouds: Codable {
    let all: Int?
}

struct WeatherSys: Codable {
    let type: Int?
    let id: Int?
    let country: String?
    let sunrise: Int?
    let sunset: Int?
}
