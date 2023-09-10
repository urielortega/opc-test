//
//  ContentView.swift
//  OpenClosedPrinciple
//
//  Created by Uriel Ortega on 10/09/23.
//

import SwiftUI

struct ClockModel {
    var hours = "00"
    var minutes = "00"
    var seconds = "00"
    
    mutating func update() {
        let date = Date()
        let calendar = Calendar.current
        
        let hour = calendar.component(.hour, from: date)
        let minute = calendar.component(.minute, from: date)
        let second = calendar.component(.second, from: date)

        self.hours = String(format: "%02d", hour)
        self.minutes = String(format: "%02d", minute)
        self.seconds = String(format: "%02d", second)
    }
}

struct ClockView: View {
    @State private var vm = ClockModel()
    let timer = Timer.TimerPublisher(interval: 1, runLoop: .main, mode: .common).autoconnect()

    var body: some View {
        HStack {
            Text(vm.hours)
            Text(":")
            Text(vm.minutes)
            Text(":")
            Text(vm.seconds)
        }
        .font(.largeTitle)
        .monospacedDigit()
        .onReceive(timer) { _ in
            vm.update()
        }
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
