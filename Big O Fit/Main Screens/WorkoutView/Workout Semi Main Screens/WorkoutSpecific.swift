//
//  WorkoutSpecific.swift
//  Big O Fit
//
//  Created by Home on 7/15/20.
//  Copyright © 2020 Home. All rights reserved.
//

import SwiftUI

struct WorkoutSpecific: View {
    let workout: Workout
    
    var body: some View {
        VStack {
            Text("Your mama so fat")
            Text(workout.workoutName)
            Text(workout.groupName)
            Text(createDateString(month: workout.month, day: workout.day, year: workout.year, weekday: workout.weekday))
        }

    }
    
    
    func createDateString(month: Int, day: Int, year: Int, weekday: Int) -> String {
        let monthString = Constants.months[month - 1]
        let weekday = Constants.weekdayAbr[weekday - 1]
        
        return "\(weekday): \(monthString) \(String(day)), \(String(year))"
    }
}

struct WorkoutSpecific_Previews: PreviewProvider {
    static var previews: some View {
        WorkoutSpecific(workout: TestWorkouts.workoutList[0][0])
    }
}
