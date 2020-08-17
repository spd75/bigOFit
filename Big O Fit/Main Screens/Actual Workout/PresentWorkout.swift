//
//  PresentWorkout.swift
//  Big O Fit
//
//  Created by Home on 8/4/20.
//  Copyright © 2020 Home. All rights reserved.
//

import SwiftUI

struct PresentWorkout: View {
    @ObservedObject var timer = CountdownTimer(minutes: 5, seconds: 50)
    
    @State var buttonImage = "play.fill"
    @State var buttonImageOffset = 2
    @State var weight = 100
    @State var reps = 4
    
    var body: some View {
        VStack (spacing: 0) {
            Text("Bench Press")
                .font(.custom("Nunito-SemiBold", size: 40))
                .foregroundColor(Color.white)
                .frame(height: 40)
            MinuteTimer(timer: self.timer, fontName: "Nunito-Bold", fontSize: 90, fontColor: .white)
            Text("Set 5")
                .font(.custom("Nunito-SemiBold", size: 30))
                .foregroundColor(Color.white)
                .frame(height: 30)
            
            Spacer()
            Spacer()
            
            HStack (alignment: .center) {
                VStack (spacing: 12) {
                    Text("Weight")
                        .font(.custom("Nunito-SemiBold", size: 30))
                        .foregroundColor(Color.white)
                        .frame(height: 30)
                    NumPickerH(numValue: $weight, numIncrement: 5, fontName: "Nunito-Bold", fontSize: 30, fontColor: .white)
                        .frame(height: 30)
                }.frame(width: Constants.screenWidth * 0.4)

                Divider()
                    .frame(height: 75)
                    .padding(.horizontal, 1)
                    .background(Color.white)

                VStack (spacing: 12) {
                    Text("Reps")
                        .font(.custom("Nunito-SemiBold", size: 30))
                        .foregroundColor(Color.white)
                        .frame(height: 30)
                    NumPickerH(numValue: $reps, numIncrement: 1, fontName: "Nunito-Bold", fontSize: 30, fontColor: .white)
                        .frame(height: 30)
                }.frame(width: Constants.screenWidth * 0.4)

            }
            
            Spacer()
            Spacer()
            Spacer()
            
            Button(action: {
                self.timer.toggleTimer()
                self.toggleButtonImage()
            }) {
                Text("Finish Set")
                    .padding(.vertical, 18)
                    .padding(.horizontal, 10)
                    .font(.custom("Nunito-SemiBold", size: 30))
                    .foregroundColor(CustomColors.darkishred)
                    .frame(width: Constants.screenWidth / 1.6)
                    .background(Color.white)
                
            }
            .frame(width: Constants.screenWidth / 4, height: Constants.screenWidth / 4)
            
            

        }
        .frame(width: Constants.screenWidth, height: Constants.screenHeight * 0.78, alignment: .top)
        .edgesIgnoringSafeArea(.top)
        
    }
    
    
    func toggleButtonImage() {
        if self.buttonImage == "play.fill" {
            self.buttonImage = "pause.fill"
            self.buttonImageOffset = 0
        } else {
            self.buttonImage = "play.fill"
            self.buttonImageOffset = 2
        }
    }
}

struct PresentWorkout_Previews: PreviewProvider {
    static var previews: some View {
        PresentWorkout()
            .background(CustomColors.darkishred)
    }
}
