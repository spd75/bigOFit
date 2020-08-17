//
//  AddNewWorkout.swift
//  Big O Fit
//
//  Created by Home on 7/14/20.
//  Copyright © 2020 Home. All rights reserved.
//

import SwiftUI


extension AnyTransition {
    static var moveAndFade: AnyTransition {
        let insertion = AnyTransition.move(edge: .trailing)
            .combined(with: .opacity)
        let removal = AnyTransition.scale
            .combined(with: .opacity)
        return .asymmetric(insertion: insertion, removal: removal)
    }
}

struct WorkoutAddNew: View {
    @State var workoutName: String = ""
    @State var pickerChoice = PageTrack.workoutMain
    
    var body: some View {
        VStack (spacing: 0) {
            Image("beaver")
                .resizable()
                .cornerRadius(Constants.screenWidth / 2)
                .frame(width: Constants.screenWidth / 2, height: Constants.screenWidth / 2)
                .aspectRatio(1, contentMode: .fit)
                .padding(30)
            TextField("Workout Name", text: $workoutName)
                .padding(.horizontal, 10)
                .padding(.vertical, 10)
                .font(.custom("Nunito-Regular", size: 20))
                .background(Color.white)
            TextField("Workout Name", text: $workoutName)
                .padding(.horizontal, 10)
                .padding(.vertical, 10)
                .font(.custom("Nunito-Regular", size: 20))
                .background(Color.white)
            TextField("Workout Name", text: $workoutName)
                .padding(.horizontal, 10)
                .padding(.vertical, 10)
                .font(.custom("Nunito-Regular", size: 20))
                .background(Color.white)
            TextField("Workout Name", text: $workoutName)
                .padding(.horizontal, 10)
                .padding(.vertical, 10)
                .font(.custom("Nunito-Regular", size: 20))
                .background(Color.white)
            Spacer()
            Button(action: {
                print("hello")
            }) {
                Section {
                    Text("Add Workout")
                        .font(.custom("Nunito-SemiBold", size: 24))
                        .foregroundColor(.white)
                    
                }
                .frame(width: Constants.screenWidth * 0.78)
                .padding(.vertical, 15)
                .background(CustomColors.darkishred)
                
            }
            Spacer()

        }
    
    }
}

struct AddNewWorkout_Previews: PreviewProvider {
    static var previews: some View {
        WorkoutAddNew()
    }
}
