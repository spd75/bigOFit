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
    var workout: Workout        /// The routine on which to base the entire screen statistics
    var title: String?          /// The title of the view
    var heightProp: CGFloat?    /// The proportion fo the view compared to its  height
    var paddingBottom: CGFloat? /// Thef padding when scrolled to bottom of scroll view
    var textColor: Color?
    var optionalSubText: String?
    var shadow: CGFloat?
    
    var body: some View {
        var titlePadding: CGFloat = 8
        if optionalSubText != nil {
            titlePadding = 0
        }
        
        return VStack (spacing: 0) {
            /// Scroll view that contains all statistics
            ScrollView (.vertical, showsIndicators: false) {
                VStack {
                        VStack {
                            Text("")
                        }.frame(height: Constants.screenHeight * 0.07)
                        
                        /// Title at the top of the workout stats screen
                        Text(title ?? "Workout Stats")
                            .foregroundColor(self.textColor ?? .white)
                            .font(.custom("Nunito-Bold", size: 32))
                            .padding(.bottom, titlePadding)
                        
                        if self.optionalSubText != nil {
                            Text(self.optionalSubText!)
                                .foregroundColor(self.textColor ?? .white)
                                .font(.custom("Nunito-Regular", size: 20))
                                .padding(.bottom, 10)
                        }
                        
                        /// Table header that contains column titles
                        TextRow(leftText: "Exercise", rightText1: "Wt.", rightText2: "Rps.", fontColor: self.textColor ?? Color.white)
                        ForEach(workout.specExercises, id: \.self) { exerciseArr in
                            /// Box which contains the visuals of all the set data for each exercise
                            ExerciseBox(exercises: exerciseArr, titleSpacing: 3, fontColor: self.textColor ?? .white, setIndent: 25)
                        }
                    }
                    .padding(.horizontal, Constants.screenWidth * 0.12)
                    .padding(.bottom, (paddingBottom ?? 0.03) * Constants.screenHeight)
                }
                .padding(.bottom, 0.03 * Constants.screenHeight)

        
        }
//        .padding(.top, Constants.screenHeight * 0.06)
        .edgesIgnoringSafeArea(.top)
        
        .frame(width: Constants.screenWidth, height: Constants.screenHeight * (heightProp ?? 0.94),
               alignment: .center)
        .shadow(radius: self.shadow ?? 5)
        
    }

    
}

struct PresentWorkoutStats_Previews: PreviewProvider {
    static var previews: some View {
        PresentWorkoutStats(workout: ExerciseList.sampleWorkout, textColor: .black, optionalSubText: "This is my subtext")
            .background(CustomColors.darkishred)
    }
}
