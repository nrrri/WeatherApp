//
//  ContentViewModel.swift
//  WeatherApp
//
//  Created by Narissorn Chowarun on 2024-07-25.
//

import Foundation
import SwiftUI


class ContentViewModel: ObservableObject {
    // instead of using delegate, use ObservableObject
    
    @Published var weatherData = WeatherAPIResponse.default // Published will notify ObservableObject if it's changed
    @Published var cityName: String = ""
    var uuid = UUID()
    
    func refreshWeather() {
        guard cityName.count > 3 else { return }
        Task {
            guard let url = prepareWeatherURL() else {
                print("Invalid url")
                return
            }
            print("Started a new network call")
            let decoder = JSONDecoder()
            do {
                let (data, _) = try await URLSession.shared.data(from: url)
                let decodedData = try decoder.decode(WeatherAPIResponse.self, from: data)
                await updateUI(newData: decodedData)
            } catch {
                print("Network or decoding error: \(error.localizedDescription)")
            }
           
            
        }
    }
    
    @MainActor // mean what happen in this class is potentially changed in the ui
    private func updateUI (newData: WeatherAPIResponse) {
        weatherData = newData
        print(weatherData)
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
