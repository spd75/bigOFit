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
    @EnvironmentObject var user: BigOFitUser
    @ObservedObject var viewRouter: ViewRouter  /// Observed object that works with WorkoutsMotherView to determine certain display aspects
    @Binding var selectedAddNewRoutineString: [String]
    @Binding var selectedQuickStartRoutineString: [String]
    @Binding var scheduledWorkouts: [[Workout]]
    
    var body: some View {
        return ScrollView(.vertical) {
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
                .clipped()
                .shadow(color: Color(red: 135/255, green: 135/255, blue: 135/255), radius: 3, y: 2)
            }
                Spacer()
                Spacer()
                
                VStack {
                    ForEach(0..<self.scheduledWorkouts.count, id: \.self) { i in
                        WorkoutGroup(workouts: self.scheduledWorkouts[i], viewRouter: self.viewRouter)
                    }

                }.padding(.bottom, 20)
                
        }.onAppear {
            self.selectedAddNewRoutineString = []
            self.selectedQuickStartRoutineString = []
        }
            
    }
        
    }


struct ExerciseView_Previews: PreviewProvider {
    static var previews: some View {
        WorkoutView(viewRouter: ViewRouter(), selectedAddNewRoutineString: Binding.constant([]), selectedQuickStartRoutineString: Binding.constant([]), scheduledWorkouts: Binding.constant([]))
            .environmentObject(ExerciseList.getTestUser())
    }
}
