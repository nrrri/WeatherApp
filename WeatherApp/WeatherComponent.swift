//
//  WeatherComponent.swift
//  WeatherApp
//
//  Created by Narissorn Chowarun on 2024-07-27.
//

import SwiftUI

struct WeatherComponent: View {
    @StateObject var viewModel = ContentViewModel() // is a class / object / reference type
    
    var body: some View {
        VStack {
            Greeting(greetCity: $viewModel.cityName)
                .font(.largeTitle)
                .bold()
            
            TextField("Type your city", text: $viewModel.cityName)
                .padding(.all)
                .background(Color.white)
                .clipShape(RoundedRectangle(cornerRadius: 12))
                .shadow(color: Color(red: 190/255, green: 190/255, blue: 190/255),  radius: 4)
                .onChange(of: viewModel.cityName) { _, _ in
                    viewModel.refreshWeather()
                }
            
            // challenge 1 (easy)
            if let conditionWeather = viewModel.weatherData.weather?.first?.icon {
                let iconURL = URL(string: "https://openweathermap.org/img/wn/\(conditionWeather)@2x.png")
                if let url = iconURL {
                    AsyncImage(url: url)
                        .background(Color.white)
                        .clipShape(/*@START_MENU_TOKEN@*/Circle()/*@END_MENU_TOKEN@*/)
                        .padding(8)
                } else {
                    Text("Invalid icon URL")
                }
            } else {
                Text("")
            }
            
            
            // TBD - move to another file
            HStack(alignment: /*@START_MENU_TOKEN@*/.center/*@END_MENU_TOKEN@*/, spacing: 40) {
                if viewModel.cityName != "" {
                            
                    Text(viewModel.weatherData.weather?.first?.main ?? "")
                        .foregroundColor(.blue)
                    
                    Text("|")
                    
                    if let tempInKelvin = viewModel.weatherData.main?.temp {
                        let ctemp = kelvinToCelcious(ktemp: tempInKelvin)
                        Text("\(ctemp) C")
                    } else {
                        Text("")
                    }
                }
                
            }
            
        }
        .padding()
        .background(Color(red: 241/255, green: 241/255, blue: 241/255))
        .clipShape(
            // 1
            RoundedRectangle(
                cornerRadius: 20
            )
        )
    }
}

#Preview {
    WeatherComponent()
}

func kelvinToCelcious (ktemp:Double) -> String {
    let celcious = ktemp - 273.15
    return String(format: "%.2f", celcious)
}
