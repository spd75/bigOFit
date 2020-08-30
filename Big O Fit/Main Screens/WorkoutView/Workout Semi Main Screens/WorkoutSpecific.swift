//
//  WorkoutSpecific.swift
//  Big O Fit
//
//  Created by Home on 7/15/20.
//  Copyright © 2020 Home. All rights reserved.
//

import SwiftUI

struct WorkoutSpecific: View {
    let workout: Workout
    
    var body: some View {
        ScrollView (.vertical, showsIndicators: false) {
            VStack (spacing: 0) {
                Text(workout.routine.name)
                    .font(.custom("Nunito-SemiBold", size: 36))
                Text(String(CurrentDateTime.getDateTimeText(comp: ExerciseList.getCompletedWorkout(workout: self.workout).dateComp)))
                    .font(.custom("Nunito-SemiBold", size: 20))
                Text(workout.groupName)
                    .font(.custom("Nunito-SemiBold", size: 20))
                
                VStack {
                    ForEach(0..<self.workout.routine.exercises.count, id: \.self) { i in
                        AddingExerciseTab(exercise: self.workout.routine.exercises[i][0], setsNum: Binding.constant(self.workout.routine.exercises[i].count), timeNum: Binding.constant(self.workout.routine.restArr[i]))
                    }
                }.padding(.top, 30)
            }.padding(12)
        }

    }
    
    

}

struct WorkoutSpecific_Previews: PreviewProvider {
    static var previews: some View {
        WorkoutSpecific(workout: ExerciseList.sampleWorkout)
    }
}
