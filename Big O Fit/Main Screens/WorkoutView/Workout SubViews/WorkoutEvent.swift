//
//  WorkoutEvent.swift
//  Big O Fit
//
//  Created by Home on 7/12/20.
//  Copyright © 2020 Home. All rights reserved.
//

import SwiftUI

struct WorkoutEvent: View {
    let workout: Workout
    @ObservedObject var viewRouter: ViewRouter
    
    let screenWidth = UIScreen.main.bounds.size.width
    
    var body: some View {
        VStack (alignment: .center, spacing: 5) {
            HStack {
                VStack (alignment: .leading) {
                    CalendarDate(monthNum: workout.month ?? 0, dayNum: workout.day ?? 0, dayOfWeekNum: workout.weekday ?? 0, yearNum: workout.year ?? 0)
                }.padding(.horizontal, 5)
                
                VStack (alignment: .leading, spacing: 0) {
                    VStack (alignment: .leading) {
                        Text(workout.routine.name)
                            .font(.custom("Nunito-SemiBold", size: 20))
            
                        Text(workout.groupName)
                            .fontWeight(.medium)
                            .font(.custom("Nunito-Regular", size: 16))
                            .foregroundColor(CustomColors.darkishred)
                    }.padding(.leading, 10)

                }
                Spacer()
                Image("beaver")
                    .resizable()
                    .frame(width: 45, height: 45)
                    .cornerRadius(45)

            }
            
        }
        .frame(width: screenWidth * 0.88)
        .padding(.vertical, 0)
        .padding(.leading, 3)
        .padding(.trailing, 10)
        .background(Color.white)
        .onTapGesture(count: 1, perform: {
            self.viewRouter.currentFivePage[0] = PageTrack.workoutSpecificPage
            Workout.workoutSelected = self.workout
        })
        .clipped()
        .shadow(radius: 2, y: 1)

    }
}

struct WorkoutEvent_Previews: PreviewProvider {
    static var previews: some View {
        WorkoutEvent(workout: TestWorkouts.workoutList[0][0], viewRouter: ViewRouter())
    }
}
