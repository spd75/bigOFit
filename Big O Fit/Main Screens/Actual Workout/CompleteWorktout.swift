//
//  FinishedWorkout.swift
//  Big O Fit
//
//  Created by Sergio Diaz on 8/24/20.
//  Copyright © 2020 Home. All rights reserved.
//

import SwiftUI

struct CompleteWorkout: View {
    @ObservedObject var viewRouter: ViewRouter
    @ObservedObject var workout: Workout
    
    @EnvironmentObject var activeHolder: ActiveHolder
    @EnvironmentObject var user: BigOFitUser
    
    var body: some View {
        VStack {
            PresentWorkoutStats(workout: workout, title: "You're Done!", heightProp: 1.01, paddingBottom: 0.18)
                .overlay(
                    ActionButton(text: "Back to Home", buttonColor: .white, textColor: CustomColors.darkishred, action: {
                        self.activeHolder.workout = nil
                        self.activeHolder.routine = nil
                        self.viewRouter.currentOverallPage = .tabbedView
                        
                        let currentDate = CurrentDateTime.getUpdatedTime()
                        self.workout.dateComp = DateComponents(year: currentDate.year, month: currentDate.month, day: currentDate.day, hour: currentDate.hour, minute: currentDate.minute, weekday: currentDate.weekday)
                        self.user.addToCompletedWorkout(workout: self.workout)
                        self.user.addToPersonalRecords(workout: self.workout)
                        
                        for exercise in self.workout.exercisesPerformed {
                            exercise.addToWorkoutsIn(workout: self.workout)
                        }
                        
                    })
                    .position(x: Constants.screenWidth / 2, y: Constants.screenHeight - 35)
                        .shadow(radius: 3, x: -1, y: 1)
                )
            Spacer()


        }
        .padding(.horizontal, Constants.screenWidth * 0.03)
        .frame(width: Constants.screenWidth)
        .background(CustomColors.darkishred)
        .edgesIgnoringSafeArea(.top)
    }
}

struct CompleteWorkout_Previews: PreviewProvider {
    static var previews: some View {
        CompleteWorkout(viewRouter: ViewRouter(), workout: Workout(routine: ExerciseList.sampleRoutine2, dateComp: DateComponents(year: 2020, month: 5, day: 15, weekday: 3)))
    }
}
