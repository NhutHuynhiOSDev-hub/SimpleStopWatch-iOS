//
//  Clock.swift
//  simplestopwatch-ios
//
//  Created by NhutHuynh on 2/26/21.
//

import Combine
import Foundation

enum State {
    
    case running
    case notRunning
}

final class Clock {
    
    private let timeInterval    : TimeInterval
    private var cancellableTimer: AnyCancellable!

    @Published var timeElapsed = 0
    
    required init(timerInterval: TimeInterval) {
        self.timeInterval = timerInterval
    }
    
    func start() {
        
        self.cancellableTimer = Timer.publish(every: self.timeInterval, on: RunLoop.main, in: .default)
        .autoconnect()
        .sink(receiveValue: { (_) in
            
            self.timeElapsed += 1
        })
    }
    
    func stop() {
        
        self.timeElapsed = 0
        self.cancellableTimer?.cancel()
    }
}

