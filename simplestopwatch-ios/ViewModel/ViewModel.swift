//
//  ViewModel.swift
//  simplestopwatch-ios
//
//  Created by NhutHuynh on 2/26/21.
//

import Foundation
import Combine

final class StopwatchViewModel: ObservableObject {
    
    @Published private(set) var elapsedTime : String    = ""
    @Published private(set) var laps        : [String]  = []
    @Published private(set) var buttonText  : String    = "Start"
    
    @Published private(set) var isLapButtonDisabled     = true

    private var cancellable: AnyCancellable!
    private var clock = Clock(timerInterval: 1)

    private var state: State  = .notRunning {
        didSet {
            switch state {
                case .running    : self.updateToRunningState()
                case .notRunning : self.updateToNotRunningState()
            }
        }
    }
    
    init() {
        self.cancellable = self.clock.$timeElapsed
            .map({ $0.description })
            .assign(to: \StopwatchViewModel.elapsedTime, on: self)
    }
    
    deinit {
        
        self.clock.stop()
        self.cancellable.cancel()
    }
    
    private func updateToRunningState() {
    
        self.clock.start()
        self.buttonText = "Stop"
        self.isLapButtonDisabled = false
    }
    
    private func updateToNotRunningState() {
        
        self.clock.stop()
        self.buttonText = "Start"
        self.isLapButtonDisabled = true
    }

    func buttonTapped() { self.state = self.state == .running ? .notRunning : .running }
    
    func lap() { self.laps.append(self.elapsedTime) }
}
