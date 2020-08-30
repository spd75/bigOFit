//
//  CurrentTimeTracker.swift
//  Big O Fit
//
//  Created by Sergio Diaz on 8/27/20.
//  Copyright © 2020 Home. All rights reserved.
//

import Foundation


class CurrentDateTime {
    public static func getUpdatedTime() -> DateComponents {
        let timeZone: TimeZone? = TimeZone(identifier: TimeZone.current.identifier)
        let components: Set<Calendar.Component> = [.year, .month, .day, .hour, .minute, .weekday]
        
        let date = Date()
        var calendar = Calendar.current
        calendar.timeZone = timeZone ?? TimeZone(abbreviation: "EST")!
        
        return calendar.dateComponents(components, from: date)
    }
    
    
    public static func getTimeFrom24Hour(hour: Int, minute: Int) -> String {
        let dayTime = hour < 12 ? "AM" : "PM"
        let minuteTime = minute < 10 ? "0\(minute)" : "\(minute)"
        var hourTime = hour
        
        if hour == 0 {
            hourTime = 12
        } else if hour > 12 {
            hourTime = hour - 12
        }
        
        return "\(hourTime):\(minuteTime) \(dayTime)"
    }
    
    
    public static func dateCompIsValid(comp: DateComponents) -> Bool {
        if comp.year == nil || comp.month == nil || comp.day == nil || comp.weekday == nil || comp.hour == nil || comp.minute == nil {
            return false
        }
        
        return true
    }
    
    

    
}
