//
//  ScrollableCalendar.swift
//  Big O Fit
//
//  Created by Home on 7/12/20.
//  Copyright © 2020 Home. All rights reserved.
//

import SwiftUI
import UIKit

struct ScrollableCalendar: View {
    let screenWidth = UIScreen.main.bounds.size.width
    let calendar = Calendar.current
    @State var calPosition = 0
    
    var calName: String {
        if calPosition == 0 {
            return "This Week"
        } else if calPosition == -1 {
            return "Last Week"
        } else if calPosition == 1 {
            return "Next Week"
        }
        
        return "Week of \(Constants.months[currentWeek[0].month! - 1]) \(String(currentWeek[0].day ?? 0))"
    }
    
    @State var currentDay = Date()
    @State var currentWeek = ScrollableCalendar.genWeek(currentDay: Date())
    
    var body: some View {
        return VStack {
            NunitoTitle(text: calName, size: 16, pTop: 20)
            
            HStack {
                ForEach(currentWeek, id: \.self) { dayComp in
                    HStack {
                        Spacer()
                        CalendarDate(monthNum: dayComp.month!, dayNum: dayComp.day!, dayOfWeekNum: dayComp.weekday!, yearNum: dayComp.year!)
                        Spacer()
                    }
                    .gesture(DragGesture(minimumDistance: 25, coordinateSpace: .local)
                        .onEnded({value in
                            let distanceDragged = value.translation

                            if distanceDragged.width > 0 {
                                self.currentWeek = self.genNextWeek(goFuture: false)
                                self.calPosition -= 1
                            } else {
                                self.currentWeek = self.genNextWeek(goFuture: true)
                                self.calPosition += 1
                            }
                            

                        }))
                }
            }
            .background(Color.white)
            .clipped()
            .shadow(radius: 2, y: 1)
        }
        
    }
    
    static func genWeek(currentDay: Date) -> [DateComponents] {
        let calendar = Calendar.current
        let nextSunday = calendar.date(bySetting: .weekday, value: 1, of: currentDay)
        let currentSunday = calendar.date(byAdding: .day, value: -7, to: nextSunday!)
        var week: [DateComponents] = [calendar.dateComponents([.month, .day, .year, .weekday], from: currentSunday!)]
        
        for i in 1...6 {
            let nextDate = calendar.date(byAdding: .day, value: i, to: currentSunday!)
            let nextDateComponent = calendar.dateComponents([.month, .day, .year, .weekday], from: nextDate!)
            week.append(nextDateComponent)
        }
        
        return week
    }

    func genNextWeek(goFuture: Bool) -> [DateComponents] {
        let calendar = Calendar.current
        let multiplier = goFuture ? 1 : -1
        
        let diffWeekDay = calendar.date(byAdding: .day, value: 7 * multiplier, to: self.currentDay)
        
        self.currentDay = diffWeekDay!
        
        return ScrollableCalendar.genWeek(currentDay: diffWeekDay!)
        
    }
    
}



struct CalendarDate: View {
    let monthNum: Int
    let dayNum: Int
    let dayOfWeekNum: Int
    let yearNum: Int
    
    var body: some View {
        let month = Constants.monthAbr[self.monthNum - 1]
        let weekDay = Constants.weekdayAbr[self.dayOfWeekNum - 1]
        
        return VStack {
            Text(String(weekDay))
                .font(.custom("Nunito", size: 8))
                .foregroundColor(.gray)
            Text(String(dayNum))
                .font(.custom("Nunito-Bold", size: 23))
            Text(month)
                .font(.custom("Nunito", size: 11))
        }.padding(.vertical, 8)
    }
    
    
}

struct ScrollableCalendar_Previews: PreviewProvider {
    static var previews: some View {
        ScrollableCalendar()
    }
}
