//
//  ExerciseHistoryWorkouttab.swift
//  Big O Fit
//
//  Created by Sergio Diaz on 8/29/20.
//  Copyright © 2020 Home. All rights reserved.
//

import SwiftUI

struct ExerciseHistoryTab: View {
    var workout: Workout
    var indicies: [Int]
    
    var body: some View {
        VStack {
            HStack (spacing: 0) {
                Text(self.workout.workoutName)
                    .font(.custom("Nunito-SemiBold", size: 19))
                Spacer()
                Text(self.workout.genDateTextFromDateComp())
                    .font(.custom("Nunito-SemiBold", size: 14))
                    .foregroundColor(CustomColors.darkishred)
            }
            VStack (spacing: 8) {
                ForEach(self.indicies, id: \.self) { i in
                    VStack {
                        ForEach(0..<self.workout.specExercises[i].count, id: \.self) { j in
                            HStack (spacing: 0) {
                                Text("Set \(j + 1)")
                                    .padding(.leading, 25)
                                    .frame(width: Constants.screenWidth * 0.56, alignment: .leading)
                                Text("\(self.workout.specExercises[i][j].weight ?? 0) lbs")
                                    .frame(width: Constants.screenWidth * 0.2, alignment: .trailing)
                                Text(String(self.workout.specExercises[i][j].reps ?? 0))
                                    .frame(width: Constants.screenWidth * 0.12, alignment: .trailing)
                            }
                            .frame(width: Constants.screenWidth * 0.88)
                            .font(.custom("Nunito-SemiBold", size: 18))
                        }
                    }
                }
            }

        }
        .padding(.trailing, 3)
        .frame(width: Constants.screenWidth * 0.88)
    }
}

struct ExerciseHistoryTab_Previews: PreviewProvider {
    static var previews: some View {
        ExerciseHistoryTab(workout: ExerciseList.sampleWorkout, indicies: [1, 2])
    }
}


