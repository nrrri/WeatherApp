//
//  ContentViewModel.swift
//  WeatherApp
//
//  Created by Narissorn Chowarun on 2024-07-25.
//

import Foundation

@MainActor // mean what happen in this class is potentially changed in the ui
class ContentViewModel: ObservableObject { // instead of using delegate, use ObservableObject
    
    @Published var weatherData = WeatherAPIResponse.default // Published will notify ObservableObject if it's changed
    @Published var cityName: String = "Toronto"
    
    func refreshWeather() {
        guard cityName.count > 3 else { return }
        Task {
            guard let url = prepareWeatherURL() else { return }
            print("Started a new network call")
            let decoder = JSONDecoder()
            guard let (data, _) = try? await URLSession.shared.data(from: url) else { return }
            guard let decodedData = try? decoder.decode(WeatherAPIResponse.self, from: data) else {
                return }
//            updateUI(newData: decodedData)
        }
    }

    private func prepareWeatherURL() -> URL? {
        let queryItems = [Constants.apiKey, URLQueryItem(name: "q", value: cityName)]
        var urlComponents = Constants.baseURL
        urlComponents.queryItems = queryItems
        if let url = urlComponents.url {
            return url
        } else {
            return nil
        }
    }
    
    
}
