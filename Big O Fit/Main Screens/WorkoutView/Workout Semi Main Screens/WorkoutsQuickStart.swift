//
//  WorkoutsQuickStart.swift
//  Big O Fit
//
//  Created by Home on 7/14/20.
//  Copyright © 2020 Home. All rights reserved.
//

import SwiftUI

struct WorkoutsQuickStart: View {
    @EnvironmentObject var activeHolder: ActiveHolder
    @EnvironmentObject var user: BigOFitUser
    @ObservedObject var viewRouter: ViewRouter
    @Binding var selectedRoutineString: [String]
    
    var body: some View {
        var hasRoutines = false
        var validRoutine: Routine = Routine(name: "", description: "", exercises: [], restArr: [])
        if selectedRoutineString.count > 0 {
            hasRoutines = true
            let i = selectedRoutineString.count - 1
            validRoutine = user.getRoutineFromName(name: self.selectedRoutineString[i])
        }
        let validWorkout = Workout(routine: validRoutine, dateComp: DateComponents(year: 2020, month: 8, day: 3,weekday: 4))
        
        return VStack (spacing: 25) {
            VStack {
                Text("Quick Workout")
                    .font(.custom("Nunito-Bold", size:30))
                    .multilineTextAlignment(.center)
                    .padding(.bottom, 0)
                Text("Select a routine by taping on the empty space below. To switch routines, hold down on the routine space. To try a new routine, go to the create tab and create new exercies and/or a new routine!")
                    .lineLimit(10)
                    .font(.custom("Nunito-Regular", size: 18))
                    .multilineTextAlignment(.center)
            }
            .padding(.horizontal, 20)
            .padding(.bottom, 20)
            .padding(.top, 13)
            .frame(width: Constants.screenWidth)
            .background(Color.white)
            .clipped()
            .shadow(radius: 2, y: 2)


            if !hasRoutines {
                Rectangle()
                    .foregroundColor(Color.white)
                    .border(Color(red: 210/255, green: 210/255, blue: 210/255))
                    .frame(width: Constants.screenWidth * 0.88, height: 100)
                    .overlay(
                        Text("Click here to select a routine.")
                            .font(.custom("Nunito-Regular", size: 18))
                    )
                    .onTapGesture {
                        self.viewRouter.currentFivePage[0] = PageTrack.workoutQuickStartRoutineSearch
                    }
                    .clipped()
                    .shadow(radius: 2, y: 1)
            } else {
                RoutineTab(viewRouter: self.viewRouter, currentSpecRoutine: Binding.constant(Routine(name: "", description: "", exercises: [], restArr: [])), routine: validRoutine, routineSize: 19, imageRad: 28, descriptionSize: 12)
                    .frame(width: Constants.screenWidth * 0.88, height: 100)
                    .contentShape(Rectangle())
                    .onTapGesture {
                        self.viewRouter.currentFivePage[0] = PageTrack.workoutQuickStartRoutineSearch
                    }
                    
            }

            Spacer()
            
            ActionButton(text: "Start Workout", action: {
                if validRoutine.name != "" {
                    self.selectedRoutineString = []
                    self.activeHolder.routine = validRoutine
                    self.activeHolder.workout = validWorkout
                    self.viewRouter.currentFivePage[0] = .workoutMain
                    self.viewRouter.currentOverallPage = PriorityPageTrack.activeWorkout
                }

            })
                
        }
        .padding(.bottom, Constants.screenHeight * 0.04)
        .frame(width: Constants.screenWidth)
            
        
        
    }
}

struct WorkoutsQuickStart_Previews: PreviewProvider {
    static var previews: some View {
        WorkoutsQuickStart(viewRouter: ViewRouter(), selectedRoutineString: Binding.constant([]))
    }
}
