//
//  ExerciseView.swift
//  Big O Fit
//
//  Created by Home on 7/12/20.
//  Copyright © 2020 Home. All rights reserved.
//

import SwiftUI


/** WorkoutView is the main screen within the Workouts
    tab which displays a scrollable calendar at the top and
    all scheduled workouts for the future.
*/
struct WorkoutView: View {
    @ObservedObject var viewRouter: ViewRouter  /// Observed object that works with WorkoutsMotherView to determine certain display aspects
    let work = TestWorkouts.workoutList
    
    var body: some View {
        ScrollView(.vertical) {
            VStack(spacing: 0) {
                ScrollableCalendar()
                Spacer()
                Spacer()
                
                Button(action: {
                    self.viewRouter.currentFivePage[0] = PageTrack.workoutQuickStartPage
                }) {
                    HStack {
                        Image(systemName: "play")
                            .font(.system(size: 40))
                            .padding(0)
                            .foregroundColor(.white)
                        Text("Quick Start")
                            .font(.custom("Nunito-SemiBold", size: 15))
                            .padding(0)
                            .foregroundColor(.white)
                    }
                    .frame(width: Constants.screenWidth * 0.78)
                    .padding(.vertical, 15)
                    .background(CustomColors.darkishred)
                }
                
            }
                Spacer()
                Spacer()
                
                VStack {
                    ForEach(TestWorkouts.workoutList, id: \.self) { workoutG in
                        WorkoutGroup(workouts: workoutG, isThisWeek: false, viewRouter: self.viewRouter)
                    }

                }.padding(.bottom, 20)
                
            }
            
        }
        
    }


struct ExerciseView_Previews: PreviewProvider {
    static var previews: some View {
        WorkoutView(viewRouter: ViewRouter())
    }
}
