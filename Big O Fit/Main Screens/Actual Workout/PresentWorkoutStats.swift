//
//  PresentWorkoutStats.swift
//  Big O Fit
//
//  Created by Home on 8/9/20.
//  Copyright © 2020 Home. All rights reserved.
//

import SwiftUI

/** Present workout stats provides a clean display of all the exercises within a workout
    and will display statistics when an exercise is complete.
 
    Practically, PresentWorkoutStats is one of the three  subviews of the ActiveWorkout view,
    which becomes active when a workout is being performed.
 */

struct PresentWorkoutStats: View {
    var routine: Routine        /// The routine on which to base the entire screen statistics
    
    var body: some View {
        return VStack (spacing: 0) {
            
            /// Title at the top of the workout stats screen
            Text("Workout Summary")
                .foregroundColor(.white)
                .font(.custom("Nunito-Bold", size: 32))
                .padding(.bottom, 8)
            
            ///
            ScrollView (.vertical, showsIndicators: false) {
                
                /// Table header that contains column titles
                TextRow(leftText: "Exercise", rightText1: "Wt.", rightText2: "Rps.")
                ForEach(routine.exercises, id: \.self) { exerciseArr in
                    /// Box which contains the visuals of all the set data for each exercise
                    ExerciseBox(exercises: exerciseArr, titleSpacing: 3, setIndent: 25)
                }
            }.padding(.horizontal, Constants.screenWidth * 0.12)

        
        }
        .padding(.top, 55)
        .edgesIgnoringSafeArea(.top)
        .frame(width: Constants.screenWidth, height: Constants.screenHeight * 0.94, alignment: .center)
        
    }

    
}

struct PresentWorkoutStats_Previews: PreviewProvider {
    static var previews: some View {
        PresentWorkoutStats(routine: ExerciseList.sampleRoutine)
            .background(CustomColors.darkishred)
    }
}
