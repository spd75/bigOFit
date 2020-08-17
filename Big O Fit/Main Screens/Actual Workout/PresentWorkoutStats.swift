//
//  PresentWorkoutStats.swift
//  Big O Fit
//
//  Created by Home on 8/9/20.
//  Copyright © 2020 Home. All rights reserved.
//

import SwiftUI

struct PresentWorkoutStats: View {
    var body: some View {
        VStack {
            Text("hi")
                .foregroundColor(Color.white)
        }
        .frame(width: Constants.screenWidth, height: Constants.screenHeight * 0.7, alignment: .center)

    }
}

struct PresentWorkoutStats_Previews: PreviewProvider {
    static var previews: some View {
        PresentWorkoutStats()
            .background(CustomColors.darkishred)
    }
}
