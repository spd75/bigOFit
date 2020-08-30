//
//  ScollScreen.swift
//  Big O Fit
//
//  Created by Home on 8/9/20.
//  Copyright © 2020 Home. All rights reserved.
//

import SwiftUI

/** Active workout is the view which takes the user through a current workout,
    keeping track of times for intervals and recording statistics for the workout.
 
    Within active workout, I have implemented a progressive scrolling method which allows
    for traditional swiping between screens (not yet implemented in SwiftUI)
 
    AcriveWorkout is composed of 3 main subviews:
    - PauseScreen
    - PresentWorkout
    - PresentWorkoutStats
 */

struct ActiveWorkout: View {
    @ObservedObject var viewRouter: ViewRouter
    @State var xoffset: CGFloat = 0                         /// Offset of window to control scrolling
    @State var xoffsetTabBar: CGFloat = 0                   /// Offset of tab bar at bottom of screen to make sure it doesn't move relative to screen
    @State var page = 1                                     /// Keeps track of which page is active for the tab bar
    @State var changePage = false                           /// Boolean value that toggles when the screen is being swipped
    @State var backgroundColor = CustomColors.darkishred    /// Color that tracks what color the background is
    @State var isPaused = false                             /// Boolean that toggles when the pause button is pressed
    
    @ObservedObject var workoutTimer = FlexTimer()          /// Timer that tracks overall set time and resting time
    
    @ObservedObject var workout: Workout                    /// The actual routine being executed
    let scrollConstant: CGFloat = 44                        /// The amount to move each
    let timer = Timer.publish(                              /// Timer that assists in scrolling by changing the xoffset exery interval
                    every: 0.01, on: .current, in: .common
                ).autoconnect()
    
    @EnvironmentObject var user: BigOFitUser
    
    
    /// The ranges for each screen which the user must swipe past in order to change screens in that direction
    let ranges = [
                    [9999, Constants.screenWidth * 1.78],
                    [Constants.screenWidth * 0.22, -Constants.screenWidth * 0.22],
                    [-Constants.screenWidth * 1.78, -9999]
                ]
    
    /// The resting position of each page
    let finalPagePositions = [
                                Constants.screenWidth * 2,
                                0,
                                -Constants.screenWidth * 2
                            ]
   
    
    var body: some View {
        return VStack {
            
            /// The container for all 3 sub-screens which make up the view
            HStack (spacing: 0) {
                PauseScreen(viewRouter: self.viewRouter, isPaused: $isPaused, timer: workoutTimer, backgroundColor: $backgroundColor)
                PresentWorkout(workout: workout, timer: workoutTimer, isPaused: $isPaused, textColor: $backgroundColor)
                PresentWorkoutStats(workout: workout)
            }
            
            /// The tab bar at the bottom of the screen that indicates which of the 3 screens is active
            CustomCircleIndicator(totalScreenNum: 3, currentScreen: $page)
                .offset(x: xoffsetTabBar / 2, y: 0)
                .frame(width: 50)
                .foregroundColor(Color.white)
            
        }
        .contentShape(Rectangle())
        .gesture(
            
            /// The gesture which determines if the screen will swipe to another screen or not
            DragGesture()
                .onChanged({drag in
                    let changed = drag.startLocation.x - drag.location.x
                    self.xoffset -= changed * 1.5
                    self.xoffsetTabBar += changed * 1.5
                })
                .onEnded({drag in
                    self.determineLimits()
                })
        )
        .onReceive(timer, perform: {_ in
            if self.changePage {
                self.convergeOffset(to: self.finalPagePositions[self.page])
            }
        })
        .frame(width: Constants.screenWidth * 5)
        .background(backgroundColor)
        .offset(x: xoffset / 2, y: 0)
        .edgesIgnoringSafeArea(.top)
        
    }
    
    
    /** Mainly called when finger is lifted after a DragGesture()
        If distance of drag exceeds one of the values in the ranges variable,
        the current page number is changed and changePage will become true.
     */
    func determineLimits() {
        if self.xoffset > self.ranges[self.page][0] {
            self.page -= 1
            self.changePage = true
        } else if self.xoffset < self.ranges[self.page][1] {
            self.page += 1
            self.changePage = true
        } else if self.xoffset != self.finalPagePositions[self.page] {
            self.changePage = true
        } else {
            self.changePage = false
        }
    }
    
    /** Function that converges over time to the offset state variable to the position provided.
        - Parameter position: the xposition that is converged to
     */
    func convergeOffset(to position: CGFloat) {
        let greatPos = position + self.scrollConstant + 1
        let lessPos = position - self.scrollConstant - 1
        
        if self.xoffset > position && self.xoffset > greatPos {
            self.xoffset -= self.scrollConstant
            self.xoffsetTabBar += self.scrollConstant
        } else if self.xoffset < position && self.xoffset < lessPos {
            self.xoffset += self.scrollConstant
            self.xoffsetTabBar -= self.scrollConstant
        } else if self.xoffset > position && self.xoffset < greatPos {
            self.xoffset = position
            self.changePage = false
            self.xoffsetTabBar = -position
        } else if self.xoffset < position && self.xoffset > lessPos {
            self.xoffset = position
            self.xoffsetTabBar = -position
            self.changePage = false
        } else {
            self.xoffsetTabBar = -position
            self.changePage = false
        }
    }
    
}


struct ScollScreen_Previews: PreviewProvider {
    static var previews: some View {
        ActiveWorkout(viewRouter: ViewRouter(), workout: ExerciseList.sampleWorkout)
        

    }
}
