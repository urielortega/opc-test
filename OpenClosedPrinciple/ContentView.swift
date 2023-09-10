//
//  ContentView.swift
//  OpenClosedPrinciple
//
//  Created by Uriel Ortega on 10/09/23.
//

import SwiftUI

struct ClockView: View {
    let hours = "00"
    let minutes = "00"
    let seconds = "00"

    var body: some View {
        HStack {
            Text(hours)
            Text(":")
            Text(minutes)
            Text(":")
            Text(seconds)
        }
        .font(.largeTitle)
        .monospacedDigit()
    }
}

struct ContentView: View {
    var body: some View {
        VStack {
            ClockView()
        }
        .padding()
    }
}


struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView()
    }
}
