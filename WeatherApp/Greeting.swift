//
//  Greeting.swift
//  WeatherApp
//
//  Created by Narissorn Chowarun on 2024-07-27.
//

import SwiftUI

struct Greeting: View {
    @Binding var greetCity: String // recieve data from another view
    
    var body: some View {
        Text("Hello, \(greetCity)")
        
//        Button("Change it", action: {
//            greetCity = "Changed"
//        })
    }
}
