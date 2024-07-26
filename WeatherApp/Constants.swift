//
//  Constants.swift
//  WeatherApp
//
//  Created by Narissorn Chowarun on 2024-07-25.
//
import Foundation

enum KeyConstants {
  static func loadAPIKeys() async throws  {
    let request = NSBundleResourceRequest(tags: ["APIKey"])
    try await request.beginAccessingResources()

    let url = Bundle.main.url(forResource: "APIKey", withExtension: "json")!
    let data = try Data(contentsOf: url)
    // TODO: Store in keychain and skip NSBundleResourceRequest on next launches
    APIKey.storage = try JSONDecoder().decode([String: String].self, from: data)

    request.endAccessingResources()
  }

  enum APIKey {
    static fileprivate(set) var storage = [String: String]()

    static var mySecretAPIKey: String { storage["appid"] ?? "" }
  }
}

public class Constants {
    static let apiKey = URLQueryItem(name: "appid", value: KeyConstants.APIKey.mySecretAPIKey)
    static var baseURL: URLComponents {
        var components = URLComponents()
        components.scheme = "https"
        components.host = "api.openweathermap.org"
        components.path = "/data/2.5/weather"
        return components
    }
}
