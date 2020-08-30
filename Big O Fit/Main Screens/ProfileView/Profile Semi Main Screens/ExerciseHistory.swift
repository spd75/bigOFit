//
//  SwiftUIView.swift
//  Big O Fit
//
//  Created by Sergio Diaz on 8/29/20.
//  Copyright © 2020 Home. All rights reserved.
//

import SwiftUI

struct ExerciseHistoryScreen: View {
    var exercise: GenExercise
    
    var body: some View {
        ExerciseList.completeWorkouts1And2()
        
        let personalRecordText = (exercise.personalRecord != 0 ? "\(exercise.personalRecord) lbs" : "NA")
        
        return ScrollView(.vertical, showsIndicators: false) {
            VStack {
                Text(exercise.name)
                    .font(.custom("Nunito-Bold", size: 34))
                
                HStack (spacing: 0) {
                    Text("Personal Record: ")
                    Text(personalRecordText)
                        .foregroundColor(CustomColors.darkishred)
                }
                .font(.custom("Nunito-Regular", size: 17))
                .offset(y: -5)

                if self.exercise.workoutsIn.count > 0  {
                    VStack {
                        ForEach(0..<self.exercise.workoutsIn.count, id: \.self) { i in
                            VStack (spacing: 0) {
                                Divider()
                                    .padding(.bottom, 1)
                                    .background(CustomColors.darkGrayBackground)
                                ExerciseHistoryTab(workout: self.exercise.workoutsIn[i], indicies: self.exercise.workoutsInLocator[i])
                                    .padding(.top, 15)
                            }
                            
                        }
                        
                    }.padding(.top, 5)
                } else {
                    Text("You have never completed this exercise in a workout.")
                        .padding(.top, 15)
                        .font(.custom("Nunito-Regular", size: 24))
                        .multilineTextAlignment(.center)
                }
            }
        }
        .padding(10)
        .frame(width: Constants.screenWidth, alignment: .top)
        
    }
}

struct ExerciseHistory_Previews: PreviewProvider {
    static var previews: some View {
        ExerciseHistoryScreen(exercise: ExerciseList.allExercisesArray[3][0])
    }
}
