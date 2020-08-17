//
//  ExerciseAllGroups.swift
//  Big O Fit
//
//  Created by Home on 7/23/20.
//  Copyright © 2020 Home. All rights reserved.
//

import SwiftUI

struct ExerciseAllGroups: View {
    var bodyParts: [String]
    @Binding var exercises: [[GenExercise]]
    
    var body: some View {
        ScrollView(.vertical, showsIndicators: false) {
            VStack (alignment: .leading, spacing: 0) {
                ForEach(0..<bodyParts.count, id: \.self) { i in
                    ExerciseGroup(exerciseName: self.bodyParts[i], exerciseList: self.exercises[i])
                }
            }
        }
    }
}

struct ExerciseAllGroups_Previews: PreviewProvider {
    static var previews: some View {
        ExerciseAllGroups(bodyParts: ExerciseList.allExerciseGroups, exercises: Binding.constant(ExerciseList.allExercisesArray))
    }
}
