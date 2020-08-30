//
//  CreateView.swift
//  Big O Fit
//
//  Created by Home on 7/15/20.
//  Copyright © 2020 Home. All rights reserved.
//

import SwiftUI

struct CreateView: View {
    @EnvironmentObject var user: BigOFitUser
    
    @ObservedObject var viewRouter: ViewRouter
    @Binding var tabTracker: Int
    @Binding var currentSpecRoutine: Routine
    @Binding var newWorkoutName: String
    @Binding var newWorkoutDesc: String
    @Binding var newWorkoutMainBodyPart: [String]
    @Binding var newWorkoutIncludedBodyPart: [String]
    
    @Binding var routineName: String
    @Binding var routineDescription: String
    @Binding var exerciseStringArray: [String]
    @Binding var exerciseInfo: [[[Int]]]
    
    var body: some View {
        let createButtonText = self.tabTracker == 0 ? "Create Routine" : "Create Exercise"
        
        let subscreenTitle = self.tabTracker == 0 ? "Routines" : "Exercises"
        let subscreenInfo = self.tabTracker == 0 ? "Scroll through to see all your routines. Click on any routine to see more info." : "Scroll through to see the exercises you can use in your workouts. If you want to add another exercise just create it!"

        
        return VStack {
            ScrollView (.vertical, showsIndicators: false) {
                TabSwitcher(textArr: ["Routines", "Exercises"], currentTab: self.$tabTracker)
                    .border(Color.gray)
                    .padding(.vertical, 20)
                    .clipped()
                    .shadow(radius: 2, y: 1)

                
                VStack {
                    ActionButton(text: createButtonText, action: {
                        self.newWorkoutName = ""
                        self.newWorkoutDesc = ""
                        self.newWorkoutMainBodyPart = []
                        self.newWorkoutIncludedBodyPart = []
                        
                        self.routineName = ""
                        self.routineDescription = ""
                        self.exerciseStringArray = []
                        self.exerciseInfo = []
                        
                        if createButtonText == "Create Exercise" {
                            self.viewRouter.currentFivePage[3] = .createAddExercise
                        } else {
                            self.viewRouter.currentFivePage[3] = .createAddRoutine
                        }
                    })
                    
                }.padding(.bottom, 35)

                
                VStack {
                    VStack (spacing: 4) {
                        Text(subscreenTitle)
                            .font(.custom("Nunito-Bold", size: 25))
                        Text(subscreenInfo)
                            .font(.custom("Nunito-Regular", size: 15))
                            .padding(.horizontal, Constants.screenWidth * 0.02)
                            .multilineTextAlignment(.center)
                    }
                    .frame(width: Constants.screenWidth * 0.88)
                    .padding(.top, 15)
                    .padding(.bottom, 20)
                    .background(Color.white)
                }
                .padding(.bottom, 20)
                .clipped()
                .shadow(radius: 2, y: 1)

                
                if self.tabTracker == 0 {
                    RoutineAll(viewRouter: viewRouter, currentSpecRoutine: $currentSpecRoutine)
                } else {
                    ExerciseAllGroups(bodyParts: ExerciseList.allExerciseGroups)
                }
                
                Spacer()
            }

        }
        .frame(width: Constants.screenWidth)
    }
}

struct CreateView_Previews: PreviewProvider {
    static var previews: some View {
        CreateView(viewRouter: ViewRouter(), tabTracker: Binding.constant(0), currentSpecRoutine: Binding.constant(Routine(name: "", description: "", exercises: [], restArr: [])), newWorkoutName: Binding.constant(""), newWorkoutDesc: Binding.constant(""), newWorkoutMainBodyPart: Binding.constant([]), newWorkoutIncludedBodyPart: Binding.constant([]), routineName: Binding.constant(""), routineDescription: Binding.constant(""), exerciseStringArray: Binding.constant([]), exerciseInfo: Binding.constant([]))
    }
}
