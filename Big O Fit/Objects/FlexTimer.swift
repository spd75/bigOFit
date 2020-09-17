//
//  CountdownTimer.swift
//  Big O Fit
//
//  Created by Home on 8/6/20.
//  Copyright © 2020 Home. All rights reserved.
//

import Foundation
import SwiftUI


/// Tracks which state the Timer is currently in
enum TimerMode {
    case notStarted, countUp, countDown
}



/** FlexTimer is mainly used within the PresentWorkout ScreenView as the workout timer. FlexTimer is a timer which has the capability of counting up, couting down, and being paused. This is used to count down for rest time for each exercise, as well as count up for each exercise being currently performed.
 
    Fields:
        - isRunning: is true if the timer is either couting up or down
        - isCountingUp: is true if the timer is currently counting up
        - isCountingDown: is true if the timer is currently counting down
        - currentMode: TimerMode that tracks mode of timer
        - @Published startedState: increases everytime the timer starts counting up or down
        - @Published seconds: the current number of seconds in the timer
        - minutes: the current number of minutes in the timer
        - hours: the current number of hours in the timer
        - timeInterval: the interval of time used to change the hours/minutes/seconds of the timer (should generally be 1)
        - secondVis: the string for the number of seconds left -> displayed as "08" if seconds = 8
        - minutesVis: the string for the number of minutes left -> displayed as "08" if minutes = 8
        - hourVis: the string for the number of hours left -> displayed as "08" if hours = 8
        - timer: the Timer object which is what allows the hours/minutes/seconds to increase or decrease within the interval provided
 */


class FlexTimer: ObservableObject {
    
    /// Check lines 22-34 for field documentation
    var isRunning: Bool = false
    var isCountingUp: Bool = false
    var isCountingDown: Bool = false
    
    var currentMode: TimerMode
    @Published var startedState: Int = 0
    @Published var seconds: Int
    var minutes: Int
    var hours: Int
    var timeInterval: Double
    private var timer: Timer?

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
    
    
    /** Only constructor for FlexTimer
            - Parameter hours: assigned to hours --- default value = 0
            - Parameter minute: assigned to minutes --- default value = 0
            - Parameter seconds: assigned to seconds --- default value = 0
            - Parameter inverval: assigned to timeInterval --- default value = 1
     */
    
    init(hours: Int = 0, minutes: Int = 0, seconds: Int = 0, timeInterval: Double = 1) {
        self.hours = hours
        self.minutes = minutes
        self.seconds = seconds
        self.timeInterval = timeInterval
        self.currentMode = .notStarted
        
    }
    
    
    /// Starts counting down the timer
    func startCountDown() {
        if !self.isCountingDown {
            self.timer?.invalidate()
            self.startedState += 1
            self.isRunning = true
            self.isCountingDown = true
            self.isCountingUp = false
            self.currentMode = .countDown
            self.timer = Timer.scheduledTimer(timeInterval: TimeInterval(self.timeInterval), target: self, selector: #selector(self.countDown), userInfo: nil, repeats: true)
            RunLoop.current.add(self.timer!, forMode: .common)
        }
    }
    
    /// Starts counting up the timer
    func startCountUp() {
        if !self.isCountingUp {
            self.timer?.invalidate()
            self.startedState += 1
            self.isRunning = true
            self.isCountingUp = true
            self.isCountingDown = false
            self.currentMode = .countUp
            self.timer = Timer.scheduledTimer(timeInterval: TimeInterval(self.timeInterval), target: self, selector: #selector(self.countUp), userInfo: nil, repeats: true)
            RunLoop.current.add(self.timer!, forMode: .common)
        }
    }
    
    
    /// Pauses the timer
    func pauseTimer() {
        if self.isRunning {
            self.timer?.invalidate()
            self.isRunning = false
            self.isCountingDown = false
            self.isCountingUp = false
        }
    }
    
    
    /// Toggles the timer between either: counting up and paused or counting down and paused
    func toggleTimer() {
        if self.isRunning {
            self.pauseTimer()
        } else if self.currentMode == .countDown {
            startCountDown()
        } else {
            startCountUp()
        }
    }
    
    
    /// Toggles between countUp and paused
    func toggleCountUp() {
        if isRunning {
            self.pauseTimer()
        } else {
            self.startCountUp()
        }
    }
    
    
    /// Toggles between countDown and paused
    func toggleCountDown() {
        if isRunning {
            self.pauseTimer()
        } else {
            self.startCountDown()
        }
    }
    
    
    /** Method called everytime the timer is counting down and the timer has completed an interval.  The method deceases seconds, minutes, and hours according to the values of each other. */
    
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
    
    
    /** Method called everytime the timer is counting up and the timer has completed an interval.  The method increases seconds, minutes, and hours according to the values of each other. */
    
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
    
    /** Resets the timer to a certain time. The default case is 00:00:00
            - Parameter hours: the value to reset the hours -- default value is 0
            - Parameter minutes: the value to reset the minutes -- default value is 0
            - Parameter seconds: the value to reset the seconds -- default value is 0 */
    
    func resetTimer(hours: Int = 0, minutes: Int = 0, seconds: Int = 0) {
        self.hours = hours
        self.minutes = minutes
        self.seconds = seconds
    }
    
    
    /** Checks to see if the timer currently is equal to 00:00:00 and returns a boolean value.
            - Returns: true if the timer is zero, false otherwise */
    
    func isZero() -> Bool {
        if self.hours == 0 && self.minutes == 0 && self.seconds == 0 {
            return true
        }
        return false
    }
    
    
}
