//
//  WorkoutLogData.swift
//  Big O Fit
//
//  Created by Sergio Diaz on 8/28/20.
//  Copyright © 2020 Home. All rights reserved.
//

import SwiftUI

struct WorkoutLogData: View {
    @Binding var currentWorkout: Workout
    
    var body: some View {
        VStack {
            PresentWorkoutStats(workout: self.currentWorkout, title: currentWorkout.workoutName, textColor: .black, optionalSubText: self.currentWorkout.genCompleteTextFromDateComp(), shadow: 0)
        }

    }
}

struct WorkoutLogData_Previews: PreviewProvider {
    static var previews: some View {
        WorkoutLogData(currentWorkout: Binding.constant(ExerciseList.sampleWorkout))
    }
}
