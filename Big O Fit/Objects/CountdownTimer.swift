//
//  CountdownTimer.swift
//  Big O Fit
//
//  Created by Home on 8/6/20.
//  Copyright © 2020 Home. All rights reserved.
//

import Foundation
import SwiftUI


class CountdownTimer: ObservableObject {
    var isRunning: Bool = false
    var isZero: Bool = false
    
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
        
        if hours == 0 && minutes == 0 && seconds == 0 {
            self.isZero = true
        }
    }
    
    
    func startTimer() {
        if !self.isRunning {
            self.pressed += 1
            self.isRunning = true
            self.timer = Timer.scheduledTimer(timeInterval: TimeInterval(self.timeInterval), target: self, selector: #selector(self.runTimer), userInfo: nil, repeats: true)
            RunLoop.current.add(self.timer!, forMode: .common)
        }
    }
    
    
    func pauseTimer() {
        if self.isRunning {
            self.timer?.invalidate()
            self.isRunning = false
        }
    }
    
    func toggleTimer() {
        if isRunning {
            self.pauseTimer()
        } else {
            self.startTimer()
        }
    }
    
    @objc private func runTimer() {
        if self.seconds > 0 {
            self.seconds -= 1
        } else if self.minutes > 0 {
            self.seconds = 59
            self.minutes -= 1
        } else if self.hours > 0 {
            self.seconds = 59
            self.minutes = 59
            self.hours -= 1
        } else {
            self.timer!.invalidate()
            self.isRunning = false
            self.isZero = true
        }
    }
    
    func resetTimer(hours: Int = 0, minutes: Int = 0, seconds: Int = 0) {
        self.hours = hours
        self.minutes = minutes
        self.seconds = seconds
        if hours == 0 && minutes == 0 && seconds == 0 {
            self.isZero = true
        }
    }
    
    
}
