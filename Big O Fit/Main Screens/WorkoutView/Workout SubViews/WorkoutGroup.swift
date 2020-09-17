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
            if workouts.count > 0 {
                NunitoTitle(text: "\(Constants.months[workouts[0].month! - 1]) \(workouts[0].year!)")
                ForEach(0..<workouts.count, id: \.self) { i in
                    WorkoutEvent(workout: self.workouts[i], viewRouter: self.viewRouter)
                }
            }
        }
    }
    
    
    func isThisWeek() -> String {
        if self.workouts.count == 0 {
            return ""
        }
        
        if self.workouts[0].isThisWeek() {
            return "This Week"
        }
        
        return "\(Constants.months[workouts[0].month! - 1]) \(workouts[0].year!)"
    }
}

struct WorkoutGroup_Previews: PreviewProvider {
    static var previews: some View {
        WorkoutGroup(workouts: TestWorkouts.workoutList[0], viewRouter: ViewRouter())
    }
}
