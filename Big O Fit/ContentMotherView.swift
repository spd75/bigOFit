//
//  ContentMotherView.swift
//  Big O Fit
//
//  Created by Sergio Diaz on 8/24/20.
//  Copyright © 2020 Home. All rights reserved.
//

import SwiftUI

struct ContentMotherView: View {
    @ObservedObject var viewRouter = ViewRouter()
    @EnvironmentObject var activeHolder: ActiveHolder
    @EnvironmentObject var user: BigOFitUser
    
    
    var body: some View {
        return VStack {
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
