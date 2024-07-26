//
//  ContentView.swift
//  WeatherApp
//
//  Created by Narissorn Chowarun on 2024-07-25.
//

import SwiftUI

struct ContentView: View {
    @StateObject var viewModel = ContentViewModel() // is a class / object / reference type
    var body: some View {
        VStack {
            TextField("Type your city", text: $viewModel.cityName)
                .padding(.all)
                .border(/*@START_MENU_TOKEN@*/Color.black/*@END_MENU_TOKEN@*/, width: 1)
                .onChange(of: viewModel.cityName) { _, _ in
                    viewModel.refreshWeather()
                }
            Text(viewModel.weatherData.name ?? "City not found")
                .font(.largeTitle)
            Text(viewModel.weatherData.weather?.first?.main ?? "City not found")
        }
        .padding()
    }
}

#Preview {
    ContentView()
}
