//
//  ExerciseGroup.swift
//  Big O Fit
//
//  Created by Home on 7/17/20.
//  Copyright © 2020 Home. All rights reserved.
//

import SwiftUI
 
/** Takes a series of exercise tabs and organizes them according to the primary muscle groups they train.
    
    All exercises currently come from Exercise.swift
 */
struct ExerciseGroup: View {
    var exerciseName: String
    var exerciseList: [GenExercise]
    
    var body: some View {
        var willShow = false
        
        if self.exerciseList.count > 0 {
            willShow = true
        }
        
        return VStack (spacing: 0) {
            if willShow {
                NunitoTitle(text: exerciseName, pHorizontal: ExerciseTab.horizPadding + Constants.screenWidth * 0.06)
                ScrollView(.horizontal, showsIndicators: false) {
                    HStack {
                        ForEach(exerciseList, id: \.self) { exercise in
                            ExerciseTab(exercise: exercise)
                                .padding(.horizontal, 0)
                        }
                    }.padding(.vertical, 2)
                }
                .frame(width: Constants.screenWidth,alignment: .leading)
                .padding(.bottom, 20)
            }

        }
        .padding(0)
    
    }
    
    
}



struct ExerciseGroup_Previews: PreviewProvider {
    static var previews: some View {
        ExerciseGroup(exerciseName: "Chest", exerciseList: ExerciseList.allExercisesArray[0])
    }
}
