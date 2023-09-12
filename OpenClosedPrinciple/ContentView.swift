//
//  ContentView.swift
//  OpenClosedPrinciple
//
//  Created by Uriel Ortega on 10/09/23.
//

import SwiftUI
import Combine

class ClockViewModel: ObservableObject {
    @Published var hours = "00"
    @Published var minutes = "00"
    @Published var seconds = "00"
    
    private var cancellables = Set<AnyCancellable>()
    
    init() {
        Timer.publish(every: 1, on: .main, in: .common).autoconnect()
            .sink { _ in
                self.update()
            }
            .store(in: &cancellables)
    }
    
    func update() {
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

struct ContentView: View {
    // 1. Creating shared viewModel with @StateObject.
    @StateObject var viewModel = ClockViewModel()
    
    var body: some View {
        VStack {
            // Injecting the model 👇
            ClockView(viewModel: viewModel)
        }
        .padding()
    }
}

struct ClockView: View {
    // 2. Using the viewModel in a different view with @ObservedObject.
    @ObservedObject var viewModel: ClockViewModel

    var body: some View {
        HStack {
            Text(viewModel.hours)
            Text(":")
            Text(viewModel.minutes)
            Text(":")
            Text(viewModel.seconds)
        }
        .font(.largeTitle)
        .monospacedDigit()
    }
}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView()
    }
}
