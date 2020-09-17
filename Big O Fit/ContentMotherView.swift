//
//  ContentMotherView.swift
//  Big O Fit
//
//  Created by Sergio Diaz on 8/24/20.
//  Copyright © 2020 Home. All rights reserved.
//

import SwiftUI

/** ContentMotherView controls which ScreenView is currently opened. The two possible ScreenViews that could be opened from this MotherView are:
        - Tabbed View: the main view of the app where the user can schedule workouts, create routines and exercises, view personal records, etc.
        - Active Workout Screen: the view used when a workout is currently taking place.
 
    Fields:
        - @ObservedObject viewRouter: object controls which screen is currently shown through the use of mother views
        - @EnvironmentObject activeHolder: the class which contains the current routine and workout selected to perform.
        - @Environment user: the object which contains all the information for the current user using the application
 */

struct ContentMotherView: View {
    @ObservedObject var viewRouter = ViewRouter()
    @EnvironmentObject var activeHolder: ActiveHolder
    @EnvironmentObject var user: BigOFitUser
    
    
    var body: some View {
        return VStack {
            
            // If currentOverallPage is changed in viewRouter, the screen displayed also changes
            if viewRouter.currentOverallPage == .tabbedView {
                TabbedView(viewRouter: self.viewRouter)
            } else if viewRouter.currentOverallPage == .activeWorkout {
                ActiveWorkoutMotherView(viewRouter: self.viewRouter, workout: self.activeHolder.workout!)
            }
        }
    }
}

struct ContentMotherView_Previews: PreviewProvider {
    static var previews: some View {
        ContentMotherView(viewRouter: ViewRouter())
    }
}
