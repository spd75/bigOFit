//
//  PauseScreen.swift
//  Big O Fit
//
//  Created by Sergio Diaz on 8/19/20.
//  Copyright © 2020 Home. All rights reserved.
//

import SwiftUI

/** PauseScreen is simply a view with a pause button which then alters a pause variable
    that is used within the superviewl

    Practically, PauseScreen is one of the three  subviews of the ActiveWorkout view,
    which becomes active when a workout is being performed.
*/

struct PauseScreen: View {
    @ObservedObject var viewRouter: ViewRouter
    @State var imageName: String = "pause"  /// The system name for image in the pause button
    @State var buttonPadding: CGFloat = 0   /// The padding for the pause button (play button is off center and requires some padding)
    @Binding var isPaused: Bool             /// Binded variable that is toggled when the pause button is pressed
    
    @ObservedObject var timer: FlexTimer    /// Observed object that is mainly used within this struct to control pauses/resumes
    @Binding var backgroundColor: Color     /// The background color of the entire active workout interface which is toggled when the pause button is pressed
    
    var body: some View {
        VStack {
            /// Pause button which controls whether the active workout is resumed or paused
            Button(action: {
                
                if self.imageName == "pause" {
                    self.imageName = "play"
                    self.buttonPadding = 5
                    self.backgroundColor = CustomColors.darkGrayBackground
                    self.isPaused = true
                } else {
                    self.imageName = "pause"
                    self.buttonPadding = 0
                    self.backgroundColor = CustomColors.darkishred
                    self.isPaused = false
                }
                
                self.timer.toggleTimer()
            }) {
                Circle()
                    .overlay(
                        Image(systemName: imageName)
                            .resizable()
                            .aspectRatio(contentMode: .fit)
                            .foregroundColor(backgroundColor)
                            .frame(height: Constants.screenHeight * 0.05)
                            .padding(.leading, buttonPadding)
                    )
                    .aspectRatio(contentMode: .fit)
                    .foregroundColor(.white)
                    .frame(width: Constants.screenWidth * 0.22)
                    
            }
            
            if self.isPaused {
                
                ActionButton(text: "Quit", widthRatio: 0.34, fontSize: 35, buttonColor: Color.white, buttonPadding: 20, textColor: CustomColors.darkGrayBackground, action: {
                        self.viewRouter.currentOverallPage = .tabbedView
                    })
            } else {
                ActionButton(text: "Quit", widthRatio: 0.34, fontSize: 35, buttonPadding: 20, action: {})
                    .hidden()
            }

            
        }
        .frame(width: Constants.screenWidth, height: Constants.screenHeight * 0.85)
        .padding(.top, Constants.screenHeight * 0.11)
        .clipped()
        .shadow(radius: 5, y: 1)
        

    }
}


struct PauseScreen_Previews: PreviewProvider {
    static var previews: some View {
        PauseScreen(viewRouter: ViewRouter(), isPaused: Binding.constant(false), timer: FlexTimer(), backgroundColor: Binding.constant(CustomColors.darkishred))
            .background(CustomColors.darkishred)
    }
}
