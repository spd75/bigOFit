//
//  PresentWorkout.swift
//  Big O Fit
//
//  Created by Home on 8/4/20.
//  Copyright © 2020 Home. All rights reserved.
//

import SwiftUI

/** PresentWorkout provides a view in which the user can keep track of the set time, rest time, weight,
    and repititions performed within an active workout.
 
    Practically, it is one of the three subviews used within the ActiveWorkout screen,
    which is activated when the user is performing a workout.
 */

struct PresentWorkout: View {
    var routine: Routine
    
    @ObservedObject var timer: FlexTimer    /// FlexTimer object which tracks time of sets and rest periods
    @Binding var isPaused: Bool             /// Binded variable that pauses the timer
    @State var onRest = false               /// Boolean which determines if the current period is a set or rest period
    @State var weight = 100                 /// Number for the weight slider
    @State var reps = 4                     /// Number for the reps slider
    @Binding var textColor: Color           /// Color of the "Finish Set" slider
    
    var body: some View {
        var largeText: String = self.routine.currentExercise.name
        
        if self.timer.isCountingDown {
            largeText = "Resting"
        } else if !isPaused {
            self.timer.startCountUp()
        }
        
        if self.timer.isZero() && timer.currentMode == .countDown {
            self.timer.startCountUp()
            self.routine.setNextExerciseCurrent()
            largeText = self.routine.currentExercise.name
            print(self.routine.currentExercise.name)
        }

        return VStack (spacing: 0) {
            
            /// The text at the top of the screen that indicates the exercise/resting period
            Text(largeText)
                .font(.custom("Nunito-SemiBold", size: 40))
                .foregroundColor(Color.white)
                .frame(height: 40)
            
            /// The large timer that counts up for exercises and down for resting time
            MinuteTimer(timer: self.timer, fontName: "Nunito-Bold", fontSize: 90, fontColor: .white)
            
            /// Text that references which set is in currently in progress
            Text("Set \(routine.currentExerciseInd[1] + 1)")
                .font(.custom("Nunito-SemiBold", size: 30))
                .foregroundColor(Color.white)
                .frame(height: 30)
            
            
            Spacer()
            Spacer()
            
            
            /// The container for the weight and repititions slider
            HStack (alignment: .center) {
                
                /// The container for the weight slider
                VStack (spacing: 12) {
                    Text("Weight")
                        .font(.custom("Nunito-SemiBold", size: 30))
                        .foregroundColor(Color.white)
                        .frame(height: 30)
                    /// The number value for the weight slider
                    NumPickerH(numValue: $weight, numIncrement: 5, fontName: "Nunito-Bold", fontSize: 30, fontColor: .white)
                        .frame(height: 30)
                }.frame(width: Constants.screenWidth * 0.4)

                /// The line which divides the weight and repititions sliders
                Divider()
                    .frame(height: 75)
                    .padding(.horizontal, 1)
                    .background(Color.white)

                /// The container for the repititions slider
                VStack (spacing: 12) {
                    Text("Reps")
                        .font(.custom("Nunito-SemiBold", size: 30))
                        .foregroundColor(Color.white)
                        .frame(height: 30)
                    /// The number value for the repititions slider
                    NumPickerH(numValue: $reps, numIncrement: 1, fontName: "Nunito-Bold", fontSize: 30, fontColor: .white)
                        .frame(height: 30)
                }.frame(width: Constants.screenWidth * 0.4)

            }
            
            
            Spacer()
            Spacer()
            Spacer()
            
            
            /// The "Finish Set" button at the bottom of the screen
            /// Changes the state to track resting period and
            /// records the weight and reps into the routine data
            Button(action: {
                if self.timer.currentMode == .countUp {
                    self.routine.changedSpecExercise += 1
                    self.timer.minutes = self.routine.currentExercise.rest[0]
                    self.timer.seconds = self.routine.currentExercise.rest[1]
                    
                    if self.timer.isRunning {
                        self.timer.startCountDown()
                    } else {
                        self.timer.pauseTimer()
                        self.timer.currentMode = .countDown
                    }
                    
                    self.onRest = true
                    self.routine.currentExercise.setResults(weight: self.weight, reps: self.reps)
                }

            }) {
                Text("Finish Set")
                    .padding(.vertical, 18)
                    .padding(.horizontal, 10)
                    .font(.custom("Nunito-SemiBold", size: 30))
                    .foregroundColor(textColor)
                    .frame(width: Constants.screenWidth / 1.6)
                    .background(Color.white)
            }
            .frame(width: Constants.screenWidth / 4, height: Constants.screenWidth / 4)
            
            

        }
        .edgesIgnoringSafeArea(.top)
        .frame(width: Constants.screenWidth, height: Constants.screenHeight * 0.85, alignment: .top)
        .padding(.top, 40)
        .padding(.bottom, 10)
    }
    
}



struct PresentWorkout_Previews: PreviewProvider {
    static var previews: some View {
        PresentWorkout(routine: ExerciseList.sampleRoutine, timer: FlexTimer(), isPaused: Binding.constant(false), textColor: Binding.constant(CustomColors.darkishred))
            .background(CustomColors.darkishred)
    }
}
