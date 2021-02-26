//
//  ContentView.swift
//  simplestopwatch-ios
//
//  Created by NhutHuynh on 2/26/21.
//

import SwiftUI

struct ContentView: View {
    
    @ObservedObject var viewModel = StopwatchViewModel()
    
    var body: some View {
        NavigationView {
            VStack(alignment: .center, spacing: 40, content: {
                Text(self.viewModel.elapsedTime)
                    .font(.system(size: 44, weight: .heavy, design: .default))
                    .multilineTextAlignment(.center)
                HStack(alignment: .center, spacing: 20) {
                    Button(self.viewModel.buttonText) {
                        self.viewModel.buttonTapped()
                    }
                    Button("Lap") {
                        self.viewModel.lap()
                    }
                    .disabled(self.viewModel.isLapButtonDisabled)
                }
                List(self.viewModel.laps, id: \.self) { time in
                    Text(time)
                }
            })
                .navigationBarTitle("Stopwatch")
        }
    }
}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView()
    }
}

