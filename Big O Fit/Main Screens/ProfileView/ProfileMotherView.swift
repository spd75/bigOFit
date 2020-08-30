//
//  ProfileMotherView.swift
//  Big O Fit
//
//  Created by Sergio Diaz on 8/25/20.
//  Copyright © 2020 Home. All rights reserved.
//

import SwiftUI

struct ProfileMotherView: View {
    @ObservedObject var viewRouter: ViewRouter
    @EnvironmentObject var user: BigOFitUser
    
    @State var currentWorkout = Workout(routine: ExerciseList.sampleRoutine, dateComp: DateComponents(year: 2020, month: 7, day: 4, hour: 5, minute: 2, weekday: 2))
    @State var currentExercise = GenExercise(name: "", description: "", bodyParts: [])
    @State var screenFrame: CGRect = CGRect()
    @State var tabTracker: Int = 0
    
    var body: some View {
        VStack {
            if viewRouter.currentFivePage[4] == .profileMain {
                ProfileMain(viewRouter: self.viewRouter, currentWorkout: self.$currentWorkout, currentExercise: self.$currentExercise, tabTracker: self.$tabTracker, screenFrame: self.$screenFrame)
                .background(CustomColors.grayBackground)
            } else if viewRouter.currentFivePage[4] == .profileViewWorkout {
                WorkoutLogData(currentWorkout: self.$currentWorkout)
                    .padding(.top, 20)
            } else if viewRouter.currentFivePage[4] == .profileViewExerciseData {
                ExerciseHistoryScreen(exercise: self.currentExercise)
            }
        }
        .background(GeometryGetter(rect: self.$screenFrame))
    }
}

struct ProfileMotherView_Previews: PreviewProvider {
    static var previews: some View {
        ProfileMotherView(viewRouter: ViewRouter())
            .environmentObject(ExerciseList.getTestUser())
    }
}
