//
//  ContentView.swift
//  WeatherApp
//
//  Created by Narissorn Chowarun on 2024-07-25.
//

import SwiftUI

struct ContentView: View {
    @State var weatherComponent = [ContentViewModel]()
    
    var body: some View {
        VStack {
            
            // Challenge adding cards
            ForEach(weatherComponent, id: \.self.uuid) { model in
                WeatherComponent(viewModel: model).padding(8)
            }
            
            HStack {
                Button("Add City") {
                    weatherComponent.append(ContentViewModel())
                    print(weatherComponent.count)
                }
                .buttonStyle(PrimaryButton())
                
                
                Button("Remove Last City") {
                    _ = weatherComponent.popLast()
                    print(weatherComponent.count)
                }
                .buttonStyle(WarningButton())
            }
            .padding(8)
            
            
        }
        .padding()
        .shadow(color: Color(red: 190/255, green: 190/255, blue: 190/255), radius: 4, x: 2, y: 2)
    }
}

#Preview {
    ContentView()
}

struct PrimaryButton: ButtonStyle {
    func makeBody(configuration: Configuration) -> some View {
        configuration.label
            .padding(10)
            .background(Color.black)
            .foregroundColor(.white)
            .clipShape(RoundedRectangle(cornerRadius: 12))
    }
}

struct WarningButton: ButtonStyle {
    func makeBody(configuration: Configuration) -> some View {
        configuration.label
            .padding(10)
            .background(Color.red)
            .foregroundColor(.white)
            .clipShape(RoundedRectangle(cornerRadius: 12))
    }
}
