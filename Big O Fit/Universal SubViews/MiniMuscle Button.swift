//
//  MiniMuscle Button.swift
//  Big O Fit
//
//  Created by Home on 7/26/20.
//  Copyright © 2020 Home. All rights reserved.
//

import SwiftUI

struct MiniMuscleAddButton: View {
    var fontSize: CGFloat?
    
    var body: some View {
        return Text("Add Muscle Group")
                .font(.custom("Nunito-SemiBold", size: fontSize ?? 15))
                .padding(.vertical, 5)
                .frame(width: Constants.screenWidth * 0.4)
                .foregroundColor(CustomColors.darkishred)
                .background(Color.white)
                .border(CustomColors.darkishred)
    }
}

struct MiniMuscleButton: View {
    var muscleName: String
    var fontSize: CGFloat?
    
    var body: some View {
        return Text(muscleName)
                .font(.custom("Nunito-SemiBold", size: fontSize ?? 15))
                .padding(.vertical, 5)
                .frame(width: Constants.screenWidth * 0.4)
                .foregroundColor(Color.white)
                .background(CustomColors.darkishred)
                .border(CustomColors.darkishred)
    }
}

struct MiniMuscle_Button_Previews: PreviewProvider {
    static var previews: some View {
        MiniMuscleButton(muscleName: "Hello")
    }
}
