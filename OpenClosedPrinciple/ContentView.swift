//
//  ContentView.swift
//  OpenClosedPrinciple
//
//  Created by Uriel Ortega on 10/09/23.
//

import SwiftUI

protocol ClockModelProtocol {
    var hours: String { set get }
    var minutes: String { set get }
    var seconds: String { set get }
    
    mutating func update()
}

struct ClockModel: ClockModelProtocol {
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

// Struct for testing purposes.
struct ClockModelTwo: ClockModelProtocol {
    var hours = "00"
    var minutes = "00"
    var seconds = "00"
    
    mutating func update() {
        hours = "11"
        minutes = "22"
        seconds = "33"
    }
}

// Now we can modify behavior without changing the code (OCP) by using dependency injection.
struct ClockView: View {
    @State var vm: ClockModelProtocol
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
            // Injecting the model 👇
            ClockView(vm: ClockModelTwo())
        }
        .padding()
    }
}


struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView()
    }
}
