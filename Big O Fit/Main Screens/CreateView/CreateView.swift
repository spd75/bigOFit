//
//  CreateView.swift
//  Big O Fit
//
//  Created by Home on 7/15/20.
//  Copyright © 2020 Home. All rights reserved.
//

import SwiftUI

struct CreateView: View {
    @ObservedObject var viewRouter: ViewRouter
    @State var isOnExercise: Bool = true
    @Binding var allExercises: [[GenExercise]]
    @Binding var newWorkoutName: String
    @Binding var newWorkoutDesc: String
    
    var body: some View {
        let createButtonText = self.isOnExercise ? "Create Exercise" : "Create Routine"

        
        return VStack {
            ScrollView (.vertical, showsIndicators: false) {
                DoubleTabSwitcher(leftText: "Exercises", rightText: "Routines", isOnLeft: $isOnExercise)
                    .padding(.vertical, 20)
                Button(action: {
                    self.newWorkoutName = ""
                    self.newWorkoutDesc = ""
                    self.viewRouter.currentFivePage[3] = .createAddExercise
                }) {
                    Section {
                        Text(createButtonText)
                            .font(.custom("Nunito-SemiBold", size: 20))
                            .foregroundColor(.white)
                    }
                    .frame(width: Constants.screenWidth * 0.78)
                    .padding(.vertical, 15)
                    .background(CustomColors.darkishred)

                }.padding(.bottom, 15)
                
                if self.isOnExercise {
                    ExerciseAllGroups(bodyParts: ExerciseList.allExerciseGroups, exercises: $allExercises)
                } 
                
                Spacer()
            }

        }
        .frame(width: Constants.screenWidth)
    }
}

struct CreateView_Previews: PreviewProvider {
    static var previews: some View {
        CreateView(viewRouter: ViewRouter(), allExercises: Binding.constant(ExerciseList.allExercisesArray), newWorkoutName: Binding.constant(""), newWorkoutDesc: Binding.constant(""))
    }
}
