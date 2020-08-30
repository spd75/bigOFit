//
//  WorkoutLogSubscreen.swift
//  Big O Fit
//
//  Created by Sergio Diaz on 8/28/20.
//  Copyright © 2020 Home. All rights reserved.
//

import SwiftUI

struct WorkoutLogSubscreen: View {
    @ObservedObject var viewRouter: ViewRouter
    @EnvironmentObject var user: BigOFitUser
    @Binding var currentWorkout: Workout
    
    var body: some View {
        VStack (spacing: 8) {
            ForEach(0..<self.user.completedWorkouts.count, id: \.self) { i in
                WorkoutLogTab(viewRouter: self.viewRouter, workout: self.user.completedWorkouts[i], currentWorkout: self.$currentWorkout)
                    .onTapGesture {
                        self.currentWorkout = self.user.completedWorkouts[i]
                        self.viewRouter.currentFivePage[4] = .profileViewWorkout
                    }
            }
        }
    }
}

struct WorkoutLogSubscreen_Previews: PreviewProvider {
    static var previews: some View {
        WorkoutLogSubscreen(viewRouter: ViewRouter(), currentWorkout: Binding.constant(ExerciseList.sampleWorkout)).environmentObject(ExerciseList.getTestUser())
    }
}
