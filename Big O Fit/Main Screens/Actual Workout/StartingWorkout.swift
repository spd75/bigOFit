//
//  StartingWorkout.swift
//  Big O Fit
//
//  Created by Sergio Diaz on 8/24/20.
//  Copyright © 2020 Home. All rights reserved.
//

import SwiftUI

struct StartingWorkout: View {
    @ObservedObject var viewRouter: ViewRouter
    @State var timeLeft = 3
    let countDown = Timer.publish(every: 1, on: .current, in: .common).autoconnect()
    
    @EnvironmentObject var user: BigOFitUser
    @ObservedObject var workout: Workout
    
    var body: some View {
        VStack {
            Spacer()
            Text(String(timeLeft))
                .font(.custom("Nunito-Bold", size: 380))
                .foregroundColor(.white)
                .clipped()
                .shadow(radius: 9, y: 3)

            Spacer()
        }
        .padding(.vertical, Constants.screenHeight * 0.04)
        .padding(.horizontal, Constants.screenWidth * 0.03)
        .frame(width: Constants.screenWidth)
        .background(CustomColors.darkishred)
        .edgesIgnoringSafeArea(.top)
        .onReceive(countDown, perform: {_ in
            print("working")
            if self.timeLeft == 1 {
                self.workout.started = true
            } else {
                self.timeLeft -= 1
            }
            
        })
        
    }
    
    
}

struct StartingWorkout_Previews: PreviewProvider {
    static var previews: some View {
        StartingWorkout(viewRouter: ViewRouter(), workout: Workout(routine: ExerciseList.sampleRoutine1, dateComp: DateComponents(year: 2020, month: 9, day: 24)))
    }
}
