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
    var isThisWeek: Bool
    @ObservedObject var viewRouter: ViewRouter
    
    var body: some View {
        let title = isThisWeek ? "This Week" : "\(Constants.months[workouts[0].month - 1]) \(workouts[0].year)"
        
        return VStack (alignment: .center, spacing: 8) {
            NunitoTitle(text: title)
            ForEach(workouts, id: \.dateComp) { workout in
                WorkoutEvent(workout: workout, viewRouter: self.viewRouter)
            }
        }
    }
}

struct WorkoutGroup_Previews: PreviewProvider {
    static var previews: some View {
        WorkoutGroup(workouts: TestWorkouts.workoutList[0], isThisWeek: false, viewRouter: ViewRouter())
    }
}
