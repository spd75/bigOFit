//
//  CurrentTimeTracker.swift
//  Big O Fit
//
//  Created by Sergio Diaz on 8/27/20.
//  Copyright © 2020 Home. All rights reserved.
//

import Foundation


class DateTime {
    public static func getUpdatedTime() -> DateComponents {
        let timeZone: TimeZone? = TimeZone(identifier: TimeZone.current.identifier)
        let components: Set<Calendar.Component> = [.year, .month, .day, .hour, .minute, .weekday]
        
        let date = Date()
        var calendar = Calendar.current
        calendar.timeZone = timeZone ?? TimeZone(abbreviation: "EST")!
        
        return calendar.dateComponents(components, from: date)
    }
    
    public static func getTimeText(hour: Int, minute: Int) -> String {
        var hourStr = String(hour)
        let minStr = (minute) < 10 ? "0\(minute)" : "\(minute)"
        let timeDayStr = hour < 12 ? "AM" : "PM"
        if hour == 0 {
            hourStr = String(12)
        } else if hour > 12 {
            hourStr = String(hour - 12)
        }
        
        return "\(hourStr):\(minStr) \(timeDayStr)"
    }
    
    public static func getDateText(comp: DateComponents) -> String {
        let year = comp.year ?? 0
        let month = (comp.month ?? 1) - 1
        let day = comp.day ?? 0
        
        if year == 0 || month == 0 || day == 0 {
            return ""
        }
        
        return "\(Constants.months[month]) \(day), \(year)"
    }
    
    
    public static func getDateTimeText(comp: DateComponents) -> String {
        let date = DateTime.getDateText(comp: comp)
        let time = DateTime.getTimeText(hour: comp.hour ?? 0, minute: comp.minute ?? 0)
        
        if date == "" {
            return ""
        }
        
        return "\(date) at \(time)"
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
    
    
    public static func getOverallTime(hour: Int, minute: Int) -> Int {
        return (hour * 60) + (minute)
    }


    public static func getOverallDateWithYear(year: Int, month: Int, day: Int) -> Int {
        var overallDate = 0
        
        if (month - 1) % 2 == 0 {
            let mult = (month - 1) / 2
            overallDate = (30 * mult) + (31 * mult)
        } else if month == 2 {
            overallDate = 31
        } else {
            let mult31 = month / 2
            let mult30 = mult31 - 1
            overallDate = (30 * mult31) + (31 * mult30)
        }
        overallDate += day
        overallDate = year % 4 == 0 ? overallDate - 1 : overallDate - 2
        overallDate = month >= 9  ? overallDate + 1 : overallDate
        
        return overallDate + (year * 365 + Int(year / 4))
    }


    public static func getDateTimeVal(year: Int, month: Int, day: Int, hour: Int, minute: Int) -> Double {
        let date = DateTime.getOverallDateWithYear(year: year, month: month, day: day)
        let time = DateTime.getOverallTime(hour: hour, minute: minute)
        
        return Double(date) + (0.0001 * Double(time))
    }
    
    public static func getDateTimeVal(comp: DateComponents) -> Double {
        return DateTime.getDateTimeVal(year: comp.year ?? 0, month: comp.month ?? 0, day: comp.day ?? 0, hour: comp.hour ?? 0, minute: comp.minute ?? 0)
    }
    


    
}
