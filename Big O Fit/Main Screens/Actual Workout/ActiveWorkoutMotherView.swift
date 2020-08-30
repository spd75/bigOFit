//
//  ActiveWorkoutMotherView.swift
//  Big O Fit
//
//  Created by Sergio Diaz on 8/21/20.
//  Copyright © 2020 Home. All rights reserved.
//

import SwiftUI

struct ActiveWorkoutMotherView: View {
    @ObservedObject var viewRouter: ViewRouter
    @ObservedObject var workout: Workout
    
    @EnvironmentObject var user: BigOFitUser
    
    var body: some View {
        VStack {
            if !workout.started {
                StartingWorkout(viewRouter: self.viewRouter, workout: self.workout)
            } else if workout.started && !workout.completed {
                ActiveWorkout(viewRouter: self.viewRouter, workout: self.workout)
            } else {
                CompleteWorkout(viewRouter: self.viewRouter, workout: self.workout)
            }

        }
    }
}

struct ActiveWorkoutMotherView_Previews: PreviewProvider {
    static var previews: some View {
        ActiveWorkoutMotherView(viewRouter: ViewRouter(), workout: Workout(routine: ExerciseList.sampleRoutine, dateComp: DateComponents(year: 2020, month: 10, day: 3, weekday: 2)))
    }
}
