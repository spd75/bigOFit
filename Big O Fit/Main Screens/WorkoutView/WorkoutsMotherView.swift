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
    @ObservedObject var viewRouter: ViewRouter
    
    var body: some View {
        return VStack {
            if self.viewRouter.currentFivePage[0] == PageTrack.workoutMain {
                WorkoutView(viewRouter: self.viewRouter)
            } else if self.viewRouter.currentFivePage[0] == PageTrack.workoutAddPage {
                WorkoutAddNew()
                    .transition(.move(edge: .trailing))
            } else if self.viewRouter.currentFivePage[0] == PageTrack.workoutQuickStartPage {
                WorkoutsQuickStart()
            } else if self.viewRouter.currentFivePage[0] == PageTrack.workoutSpecificPage {
                WorkoutSpecific(workout: Workout.workoutSelected!)
            }
        }.background(CustomColors.grayBackground)

    }
}

struct WorkoutsMotherView_Previews: PreviewProvider {
    static var previews: some View {
        WorkoutsMotherView(viewRouter: ViewRouter())
    }
}
