//
//  CountdownTimer.swift
//  Big O Fit
//
//  Created by Home on 8/6/20.
//  Copyright © 2020 Home. All rights reserved.
//

import Foundation
import SwiftUI

enum TimerMode {
    case notStarted, countUp, countDown
}


class FlexTimer: ObservableObject {
    var isRunning: Bool = false
    var isCountingUp: Bool = false
    var isCountingDown: Bool = false
    
    var currentMode: TimerMode
    @Published var seconds: Int
    @Published var pressed: Int = 0
    var minutes: Int
    var hours: Int
    var timeInterval: Double

    var secondsVis: String {
        if self.seconds < 10 {
            return "0\(self.seconds)"
        }
        return "\(self.seconds)"
    }
    
    var minutesVis: String {
        if self.minutes < 10 {
            return "0\(self.minutes)"
        }
        return "\(self.minutes)"
    }
    
    var hoursVis: String {
        if self.hours < 10 {
            return "0\(self.hours)"
        }
        return "\(self.hours)"
    }
    
    private var timer: Timer?
    
    
    init(hours: Int = 0, minutes: Int = 0, seconds: Int = 0, timeInterval: Double = 1) {
        self.hours = hours
        self.minutes = minutes
        self.seconds = seconds
        self.timeInterval = timeInterval
        self.currentMode = .notStarted
        
    }
    
    
    func startCountDown() {
        if !self.isCountingDown {
            self.timer?.invalidate()
            self.pressed += 1
            self.isRunning = true
            self.isCountingDown = true
            self.isCountingUp = false
            self.currentMode = .countDown
            self.timer = Timer.scheduledTimer(timeInterval: TimeInterval(self.timeInterval), target: self, selector: #selector(self.countDown), userInfo: nil, repeats: true)
            RunLoop.current.add(self.timer!, forMode: .common)
        }
    }
    
    func startCountUp() {
        if !self.isCountingUp {
            self.timer?.invalidate()
            self.pressed += 1
            self.isRunning = true
            self.isCountingUp = true
            self.isCountingDown = false
            self.currentMode = .countUp
            self.timer = Timer.scheduledTimer(timeInterval: TimeInterval(self.timeInterval), target: self, selector: #selector(self.countUp), userInfo: nil, repeats: true)
            RunLoop.current.add(self.timer!, forMode: .common)
        }
    }
    
    
    func pauseTimer() {
        if self.isRunning {
            self.timer?.invalidate()
            self.isRunning = false
            self.isCountingDown = false
            self.isCountingUp = false
        }
    }
    
    func toggleTimer() {
        if self.isRunning {
            self.pauseTimer()
        } else if self.currentMode == .countDown {
            startCountDown()
        } else {
            startCountUp()
        }
    }
    
    func toggleCountUp() {
        if isRunning {
            self.pauseTimer()
        } else {
            self.startCountUp()
        }
    }
    
    func toggleCountDown() {
        if isRunning {
            self.pauseTimer()
        } else {
            self.startCountDown()
        }
    }
    
    @objc private func countDown() {
        if self.seconds > 0 {
            self.seconds -= 1
        } else if self.minutes > 0 {
            self.seconds = 59
            self.minutes -= 1
        } else if self.hours > 0 {
            self.seconds = 59
            self.minutes = 59
            self.hours -= 1
        } else if self.seconds == 0 && self.minutes == 0 && self.hours == 0 {
            self.timer!.invalidate()
            self.isRunning = false
            self.isCountingDown = false
        }
    }
    
    @objc private func countUp() {
        if self.seconds < 60 {
            self.seconds += 1
        } else if self.minutes < 60 {
            self.seconds = 0
            self.minutes += 1
        } else if self.hours < 100 {
            self.seconds = 0
            self.minutes = 0
            self.hours += 1
        }
    }
    
    func resetTimer(hours: Int = 0, minutes: Int = 0, seconds: Int = 0) {
        self.hours = hours
        self.minutes = minutes
        self.seconds = seconds
    }
    
    func isZero() -> Bool {
        if self.hours == 0 && self.minutes == 0 && self.seconds == 0 {
            return true
        }
        return false
    }
    
    
}
