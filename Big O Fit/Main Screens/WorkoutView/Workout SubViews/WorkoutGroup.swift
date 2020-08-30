//
//  WorkoutGroup.swift
//  Big O Fit
//
//  Created by Home on 7/14/20.
//  Copyright © 2020 Home. All rights reserved.
//

import SwiftUI

struct WorkoutGroup: View {
    var workouts: [Workout]!
    @ObservedObject var viewRouter: ViewRouter
    
    var body: some View {
        return VStack (alignment: .center, spacing: 10) {
            NunitoTitle(text: self.isThisWeek())
            ForEach(workouts, id: \.self) { workout in
                WorkoutEvent(workout: workout, viewRouter: self.viewRouter)
            }
        }
    }
    
    
    func isThisWeek() -> String {
        let current = CurrentDateTime.getUpdatedTime()
        let year = self.workouts[0].year == current.year
        let month = self.workouts[0].month == current.month
        
        if year && month {
            if self.workouts[0].weekday! < current.weekday! && self.workouts[0].day! < current.day! {
                return "This Week"
            }
        }
        
        return "\(Constants.months[workouts[0].month! - 1]) \(workouts[0].year!)"
    }
}

struct WorkoutGroup_Previews: PreviewProvider {
    static var previews: some View {
        WorkoutGroup(workouts: TestWorkouts.workoutList[0], viewRouter: ViewRouter())
    }
}
