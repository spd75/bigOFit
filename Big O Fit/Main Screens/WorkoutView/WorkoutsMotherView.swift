//
//  WorkoutsMotherView.swift
//  Big O Fit
//
//  Created by Home on 7/14/20.
//  Copyright © 2020 Home. All rights reserved.
//

import SwiftUI

/** WorkoutsMotherView provides the MotherView for the workout tab.
    This consists of 4 subscreens:
        - The main workouts screen
        - Adding a workout screen
        - Quick start screen
        - Viewing a workout screen
        
    - Note: MotherViews are utilized along with the ViewRouter to
            control which screens are open within each tab.
 */
struct WorkoutsMotherView: View {
    @EnvironmentObject var user: BigOFitUser
    @ObservedObject var viewRouter: ViewRouter
    @State var selectedAddNewRoutineString: [String] = []
    @State var selectedQuickStartRoutineString: [String] = []
    @State var selectedRoutineQuickStart: Routine? = nil
    @State var scheduledWorkouts: [[Workout]]
    @State var chosenDateComps = DateComponents()
    
    var body: some View {
        return VStack {
            if self.viewRouter.currentFivePage[0] == PageTrack.workoutMain {
                WorkoutView(viewRouter: self.viewRouter, selectedAddNewRoutineString: self.$selectedAddNewRoutineString, selectedQuickStartRoutineString: self.$selectedQuickStartRoutineString, scheduledWorkouts: self.$scheduledWorkouts)
            } else if self.viewRouter.currentFivePage[0] == PageTrack.workoutAddPage {
                WorkoutAddNew(viewRouter: self.viewRouter, scheduledWorkouts: self.$scheduledWorkouts, selectedRoutineString: self.$selectedAddNewRoutineString, chosenDateComps: self.$chosenDateComps)
                    .transition(.move(edge: .trailing))
            } else if self.viewRouter.currentFivePage[0] == PageTrack.workoutQuickStartPage {
                WorkoutsQuickStart(viewRouter: self.viewRouter, selectedRoutineString: self.$selectedQuickStartRoutineString)
            } else if self.viewRouter.currentFivePage[0] == PageTrack.workoutSpecificPage {
                WorkoutSpecific(workout: Workout.workoutSelected!)
            } else if self.viewRouter.currentFivePage[0] == PageTrack.workoutQuickStartRoutineSearch {
                SearchScreen(viewRouter: self.viewRouter, search: Search(inputText: "", searchOptions: self.user.getRoutineArrString()), searchTitle: "Routines", pageIndex: 0, returnPage: .workoutQuickStartPage, selectedOptions: self.$selectedQuickStartRoutineString)
            } else if self.viewRouter.currentFivePage[0] == PageTrack.workoutAddNewRoutineSearch {
                SearchScreen(viewRouter: self.viewRouter, search: Search(inputText: "", searchOptions: self.user.getRoutineArrString()), searchTitle: "Routines", pageIndex: 0, returnPage: .workoutAddPage, selectedOptions: self.$selectedAddNewRoutineString)
            }
        }.background(CustomColors.grayBackground)

    }
}

struct WorkoutsMotherView_Previews: PreviewProvider {
    static var previews: some View {
        WorkoutsMotherView(viewRouter: ViewRouter(), scheduledWorkouts: [[ExerciseList.sampleWorkout]])
            .environmentObject(ExerciseList.getTestUser())
    }
}
