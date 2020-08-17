////
////  Scrollable Calendar.swift
////  Big O Fit
////
////  Created by Home on 7/11/20.
////  Copyright © 2020 Home. All rights reserved.
////
//
//import SwiftUI
//
//struct ScrollableCalendar1: View {
//    let day = Date()
//    let months: Array<String> = ["January", "February", "March", "April", "May", "June", "July", "August", "September", "October", "November", "December"]
//    var monthStartDays: Array<Int> = [1, 32, 60, 91, 121, 152, 182, 213, 244, 274, 305, 335]
//    var monthStartLeapDays: Array<Int> = [1, 33, 61, 92, 122, 153, 183, 214, 245, 275, 306, 336]
//    
//    
//    var body: some View {
//        let allDates = getYearRound(midDate: day)
//        return VStack {
//            HStack {
//                ScrollView(.horizontal, showsIndicators: false) {
//                    CalendarDateHorizBase(dates: allDates)
//                }
//            }.background(Color.white)
//            Path { path in
//                path.move(to: CGPoint(x: 20, y: -8))
//                path.addLine(to: CGPoint(x: 355, y: -8))
//            }.stroke(CustomColors.darkishred, lineWidth: 2)
//        }
//            
//
//        
//    }
//    
//    func adjustLeapYear(year: Int) -> Array<Int> {
//        if year % 4 == 0 {
//            return monthStartLeapDays
//        }
//        return monthStartDays
//    }
//    
//    
//    func getYearRound(midDate: Date) -> Array<Array<String>> {
//        let midDateVal = getNumberDateValue(date: midDate)
//        let midDay = midDateVal[0]
//        let years: Array<Int>
//        
//        var leapYears: Array<Bool> = []
//        var yearRound: Array<Array<String>> = []
//        
//        var curYearInd = 0
//        var currentDay: Int = midDay - 50
//        
//        
//        if currentDay < 0 {
//            let yearDayNums = midDateVal[1] % 4 == 0 ? 366 : 365
//            currentDay += yearDayNums
//            years = [midDateVal[1] - 1, midDateVal[1]]
//        } else if currentDay == 0 {
//            currentDay = 1
//            years = [midDateVal[1] - 1, midDateVal[1]]
//        } else {
//            years = [midDateVal[1], midDateVal[1] + 1]
//        }
//        
//        for year in years {
//            if year % 4 == 0 {
//                leapYears.append(true)
//            } else {
//                leapYears.append(false)
//            }
//        }
//        
//        for _ in 0...150 {
//            yearRound.append(getDateFromDateValue(dateVal: [currentDay, years[curYearInd]]))
//            currentDay += 1
//            
//            if leapYears[curYearInd] && currentDay >= 366 {
//                currentDay = 1
//                curYearInd += 1
//            } else if !leapYears[curYearInd] && currentDay >= 365 {
//                currentDay = 1
//                curYearInd += 1
//            }
//        
//        }
//        
//        print(leapYears)
//        return yearRound
//    }
//
//    
//    
//    func getNumberDateValue(date: Date) -> Array<Int> {
//        let stringDate: String = date.description
//        
//        let endYear = stringDate.index(stringDate.startIndex, offsetBy: 4)
//        let startMonth = stringDate.index(endYear, offsetBy: 1)
//        let endMonth = stringDate.index(startMonth, offsetBy: 1)
//        let startDay = stringDate.index(endMonth, offsetBy:2)
//        let endDay = stringDate.index(startDay, offsetBy: 1)
//        
//        let yearVal: Int = Int(stringDate[..<endYear]) ?? 0
//        let monthNum = Int(stringDate[startMonth...endMonth]) ?? 0
//        let dayNum = Int(stringDate[startDay...endDay]) ?? 0
//        
//        let dayVal = monthStartDays[monthNum - 1] + dayNum
//        
//        return [dayVal, yearVal]
//    }
//
//
//    func getDateFromDateValue(dateVal: Array<Int>) -> Array<String> {
//        let currentMonthDays = adjustLeapYear(year: dateVal[1])
//        
//        var low = 0
//        var high = monthStartDays.count - 1
//        var mid = (high - low) / 2
//        var currentMonthStart = 0
//        var currentMonthI = 0
//        
//        while high - low > 1 {
//            if monthStartDays[mid] <= dateVal[0] {
//                low = mid
//            } else {
//                high = mid
//            }
//            
//            mid = ((high - low) / 2) + low
//            if high - low <= 1 {
//                if monthStartDays[high] <= dateVal[0] {
//                    currentMonthI = high
//                    currentMonthStart = currentMonthDays[high]
//                } else {
//                    currentMonthI = low
//                    currentMonthStart = currentMonthDays[low]
//                }
//            }
//            
//        }
//        
//        let month = months[currentMonthI]
//        let day = dateVal[0] - currentMonthStart + 1
//        
//        return [month, String(day), String(dateVal[1])]
//    }
//    
//}
//
//
//struct CalendarDateHorizBase: View {
//    var dates: Array<Array<String>>
//    
//    var body: some View {
//        HStack {
//            ForEach(dates, id: \.description) { date in
//                CalendarDate(month: date[0], day: date[1], year: date[2])
//            }
//        }
//    }
//}
//
//
//struct CalendarDate1: View {
//    var month: String
//    var day: String
//    var year: String
//    
//    var body: some View {
//        VStack {
//            Text(String(day))
//                .fontWeight(.bold)
//                .font(.system(size: 40))
//            Text(month)
//                .font(.system(size: 16))
//            Text(String(year))
//                .font(.system(size: 10))
//                .foregroundColor(.gray)
//        }.padding(.horizontal, 10).padding(.vertical, 15)
//    }
//    
//    
//}
//
//struct Scrollable_Calendar_Previews: PreviewProvider {
//    static var previews: some View {
//        CalendarDate1(month: "June", day: "10", year: "2020")
//    }
//}
